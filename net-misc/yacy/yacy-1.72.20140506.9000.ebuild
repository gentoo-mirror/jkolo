# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=5

inherit eutils versionator

MAJOR_PV="$(get_version_component_range 1-2)"
REL_PV="$(get_version_component_range 3)"
SVN_PV="$(get_version_component_range 4)"

DESCRIPTION="p2p based distributed web-search engine - latest stable binary"
HOMEPAGE="http://www.yacy.net/"
SRC_URI="http://yacy.net/release/yacy_v${MAJOR_PV}_${REL_PV}_${SVN_PV}.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND=">=virtual/jdk-1.5.0"
RESTRICT="mirror"
LICENSE="GPL-2"
IUSE=""

S="${WORKDIR}/yacy"

src_install() {
        dodir /opt
        mv "${S}" "${D}/opt/${PN}"
        chown -R ${PN}:${PN} "${D}/opt/${PN}"
}

pkg_setup() {
        enewgroup ${PN}
        enewuser ${PN} -1 /bin/bash /opt/${PN} ${PN}
}

pkg_postinst() {
        einfo "This is the plain install without initscripts."
        einfo "Keep in mind, YaCy works in /opt/yacy/DATA"
        einfo "so its a good idea to move it to /var und symlink it."
        einfo "Logfiles are in /opt/yacy/DATA/LOG instead of /var/log"
        einfo "For details (in german) about YaCy on Gentoo look at:"
        einfo " http://yacy-websuche.de/wiki/index.php/De:GentooInstall"
}
