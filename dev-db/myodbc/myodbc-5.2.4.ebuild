# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/myodbc/myodbc-5.1.6.ebuild,v 1.6 2012/07/31 09:10:56 kensington Exp $

EAPI=2
inherit eutils versionator cmake-utils

MAJOR="$(get_version_component_range 1-2 $PV)"
MY_PN="mysql-connector-odbc"
MY_P="${MY_PN}-${PV/_p/r}-src"
DESCRIPTION="ODBC driver for MySQL"
HOMEPAGE="http://www.mysql.com/products/myodbc/"
SRC_URI="mirror://mysql/Downloads/Connector-ODBC/${MAJOR}/${MY_P}.tar.gz"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="${MAJOR}"
KEYWORDS="amd64 ppc x86"
IUSE="debug doc static qt4"
RDEPEND=">=virtual/mysql-4.0
		 dev-db/unixODBC
		 qt4? ( >=dev-qt/qtgui-4:4 )"
# perl is required for building docs
DEPEND="${RDEPEND}
		doc? ( dev-lang/perl )"
S=${WORKDIR}/${MY_P}

# Careful!
DRIVER_NAME="${PN}-${SLOT}"

src_configure() {
    # Add WITH_DOCUMENTATION_INSTALL_PATH and WITH_TEST_INSTALL_PATH options:
	epatch ${FILESDIR}/${PF}-cmake.patch

	# Note that setting EXE_LINKER_FLAGS shouldn't be necessary, but
	# FindODBC obviously doesn't use odbc_config to set the ODBC lib...
	local mycmakeargs=(
	 -DCMAKE_INSTALL_PREFIX:PATH=/usr 
	 -DMYSQL_LIB=/usr/lib/mysql/libmysqlclient_r.so 
	 -DWITH_UNIXODBC=On
	 -DCMAKE_EXE_LINKER_FLAGS=-lodbc
	 -DWITH_DOCUMENTATION_INSTALL_PATH=/usr/share/doc/${PF}
	)
	# for some reason this needs to be run two times to avoid 
	# that everything is compile a second time when make install 
	# is called 
	cmake-utils_src_configure
	cmake-utils_src_configure
}

src_install() {
	into /usr
	cmake-utils_src_install
	#dodoc INSTALL README
	dodir /usr/share/${PN}-${SLOT}
	for i in odbc.ini odbcinst.ini; do
		einfo "Building $i"
			sed \
			-e "s,__PN__,${DRIVER_NAME},g" \
			-e "s,__PF__,${PF},g" \
			-e "s,libmyodbc3.so,libmyodbc${SLOT:0:1}w.so,g" \
			>"${D}"/usr/share/${PN}-${SLOT}/${i} \
			<"${FILESDIR}"/${i}.m4 \
			|| die "Failed to build $i"
	done;
}

pkg_config() {
	[ "${ROOT}" != "/" ] && \
	die 'Sorry, non-standard ROOT setting is not supported :-('

	local msg='MySQL ODBC driver'
	local drivers=$(/usr/bin/odbcinst -q -d)
	if echo $drivers | grep -vq "^\[${DRIVER_NAME}\]$" ; then
		ebegin "Installing ${msg}"
		/usr/bin/odbcinst -i -d -f /usr/share/${PN}-${SLOT}/odbcinst.ini
		rc=$?
		eend $rc
		[ $rc -ne 0 ] && die
	else
		einfo "Skipping already installed ${msg}"
	fi

	local sources=$(/usr/bin/odbcinst -q -s)
	msg='sample MySQL ODBC DSN'
	if echo $sources | grep -vq "^\[${DRIVER_NAME}-test\]$"; then
		ebegin "Installing ${msg}"
		/usr/bin/odbcinst -i -s -l -f /usr/share/${PN}-${SLOT}/odbc.ini
		rc=$?
		eend $rc
		[ $rc -ne 0 ] && die
	else
		einfo "Skipping already installed ${msg}"
	fi
}

pkg_postinst() {
	elog "If this is a new install, please run the following command"
	elog "to configure the MySQL ODBC drivers and sources:"
	elog "emerge --config =${CATEGORY}/${PF}"
	elog "Please note that the driver name used to form the DSN now includes the SLOT."
}
