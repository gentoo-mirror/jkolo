# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools depend.php depend.apache multilib subversion flag-o-matic scons-utils

DESCRIPTION="ZoneMinder allows you to capture, analyse, record and monitor any cameras attached to your system."
HOMEPAGE="http://www.zoneminder.com/"
ESVN_REPO_URI="http://svn.zoneminder.com/svn/zm/trunk"
ESVN_PROJECT="${PN}"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug ffmpeg mmap"
# plugins"
SLOT="0"

DEPEND="app-admin/sudo
	dev-libs/libpcre
	virtual/jpeg
	net-libs/gnutls
	>=dev-lang/perl-5.6.0
	virtual/perl-Archive-Tar
	dev-perl/Archive-Zip
	dev-perl/DateManip
	dev-perl/DBD-mysql
	dev-perl/DBI
	dev-perl/Device-SerialPort
	dev-perl/libwww-perl
	dev-perl/MIME-Lite
	dev-perl/MIME-tools
	dev-perl/PHP-Serialization
	virtual/perl-Getopt-Long
	virtual/perl-libnet
	virtual/perl-Module-Load
	virtual/perl-Sys-Syslog
	virtual/perl-Time-HiRes
	mmap? ( dev-perl/Sys-Mmap )"
#	plugins? ( dev-util/scons )"

RDEPEND="dev-perl/DBD-mysql
	ffmpeg? ( >=media-video/ffmpeg-0.5-r1 )
	media-libs/netpbm"
#	plugins? ( media-libs/opencv
#	>=dev-libs/boost-1.40 )"

# we cannot use need_httpd_cgi here, since we need to setup permissions for the
# webserver in global scope (/etc/zm.conf etc), so we hardcode apache here.
need_apache
need_php_httpd

#S=${WORKDIR}/${MY_PN}-${MY_PV}

pkg_setup() {
	require_php_with_use mysql sockets apache2
}

src_unpack() {
#	unpack ${A}
	subversion_src_unpack
	cd "${S}"
	tar xjf "${FILESDIR}"/9999/zoneminder-facedetector-plugin.tar.bz2

	epatch "${FILESDIR}"/9999/Makefile.am.patch
	epatch "${FILESDIR}"/9999/zm_remote_camera_http.patch
	epatch "${FILESDIR}"/9999/db_upgrade_script_location.patch
#	if use plugins; then
#		epatch "${FILESDIR}"/9999/cvisionlab-plugins.patch
#	fi

	eautoreconf
}

src_compile() {
	local myconf

	append-flags "-D__STDC_CONSTANT_MACROS"
# To enable mmap support we need a dependancy of Sys::Mmap
# It installs fine via g-cpan, but there's no ebuild currently in portage.
	if use mmap; then
		myconf="${myconf} --enable-mmap=yes"
	else
		myconf="${myconf} --enable-mmap=no"
	fi

	if use debug; then
		myconf="${myconf} --enable-debug=yes --enable-crashtrace=yes"
	else
		myconf="${myconf} --enable-debug=no --enable-crashtrace=no"
	fi

	econf --with-libarch=$(get_libdir) \
		--with-mysql=/usr \
		$(use_with ffmpeg) \
		--with-webdir="${ROOT}var/www/zoneminder/htdocs" \
		--with-cgidir="${ROOT}var/www/zoneminder/cgi-bin" \
		--with-webuser=apache \
		--with-webgroup=apache \
		${myconf}

	einfo "${PN} does not parallel build... using forcing make -j1..."
	MAKEOPTS="-j1" emake || die "emake failed"
#	if use plugins; then
#		cd plugins
#		scons
#	fi
}

src_install() {
	keepdir /var/run/zm
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	fperms 0640 /etc/zm.conf

	keepdir /var/log/zm
	fowners apache:apache /var/log/zm
	fowners apache:apache /var/run/zm

	newinitd "${FILESDIR}"/init.d zoneminder
	newconfd "${FILESDIR}"/conf.d zoneminder

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO

	insinto /usr/share/${PN}/db
	doins db/zm_u* db/zm_create.sql

	insinto /etc/apache2/vhosts.d
	doins "${FILESDIR}"/10_zoneminder.conf

	for DIR in events images sound; do
		dodir /var/www/zoneminder/htdocs/${DIR}
	done

#	if use plugins; then
#		sed -i "s:zoneminder:opencv:g" ${S}/plugins/data/plugins.conf
#		insinto /usr/share/${PN}
#		newins plugins/release/face_detector_plugin.os face_detector_plugin.zmpl
#		doins plugins/data/plugins.conf
#	fi
}

pkg_postinst() {
	elog ""
	elog "0. If this is a new installation, you will need to create a MySQL database"
	elog "   for ${PN} to use. (see http://www.gentoo.org/doc/en/mysql-howto.xml)."
	elog "   Once you completed that you should execute the following:"
	elog ""
	elog " cd /usr/share/${PN}"
	elog " mysql -u <my_database_user> -p<my_database_pass> <my_zoneminder_db> < db/zm_create.sql"
	elog ""
	elog "1.  Set your database settings in /etc/zm.conf"
	elog ""
	elog "2.  Start the ${PN} daemon:"
	elog ""
	elog "  /etc/init.d/${PN} start"
	elog ""
	elog "3. Finally point your browser to http://localhost/${PN}"
	elog ""
	elog ""
	elog "If you are upgrading, you will need to run the zmupdate.pl script:"
	elog ""
	elog " /usr/bin/zmupdate.pl version=<from version> [--user=<my_database_user> --pass=<my_database_pass>]"
	elog ""
	elog "You must gave short_open_tag = On in /etc/php/php.ini"
	elog ""
}
