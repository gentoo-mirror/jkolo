# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils versionator webapp

DESCRIPTION="Personal cloud that runs on your own server"
HOMEPAGE="http://nextcloud.com"

if [[ ${PV} = *_rc1* ]]; then
	MY_PN="${PN}"
	MY_PV="$(get_version_component_range 1-2)RC1"
	MY_P="${MY_PN}-${MY_PV}"
	SRC_URI="http://download.nextcloud.com/server/prereleases/${MY_P}.tar.bz2"
else
	SRC_URI="http://download.nextcloud.com/server/releases/${P}.tar.bz2"
fi

LICENSE="AGPL-3"

KEYWORDS="~amd64 ~arm ~x86"
IUSE="+curl mysql postgres +sqlite"
REQUIRED_USE="|| ( mysql postgres sqlite )"

DEPEND=""
RDEPEND="dev-lang/php[curl?,filter,gd,hash,json,mysql?,pdo,posix,postgres?,session,simplexml,sqlite?,xmlreader,xmlwriter,zip]
	virtual/httpd-php"

S=${WORKDIR}/${PN}

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .
	dodir "${MY_HTDOCSDIR}"/data

	webapp_serverowned -R "${MY_HTDOCSDIR}"/apps
	webapp_serverowned -R "${MY_HTDOCSDIR}"/data
	webapp_serverowned -R "${MY_HTDOCSDIR}"/config
	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	webapp_src_install
}
