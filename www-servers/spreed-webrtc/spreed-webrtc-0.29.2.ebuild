# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools user

DESCRIPTION="WebRTC audio/video call and conferencing server and web client"
HOMEPAGE="https://www.spreed.me"
SRC_URI="https://github.com/strukturag/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="dev-lang/go
	>=net-libs/nodejs-5.6.0-r1"
RDEPEND=""

pkg_setup() {
	enewuser ${PN} -1 -1 /dev/null
}

src_prepare() {
	default
	eautoreconf
	npm install || die
}

src_compile() {
	emake -j1 \
		LDFLAGS=""
}

src_install() {
	default
	insinto /etc/${PN}
	newins server.conf.in ${PN}.example
	newinitd "${FILESDIR}/${PN}.init" ${PN}
	exeinto /usr/libexec
	doexe "${FILESDIR}/spreed-webrtc-checkconfig.sh"
	chown -R ${PN} "${D}/etc/${PN}"
	find "${D}/usr/share/spreed-webrtc-server" -type f -exec chmod a-x {} +
}

pkg_postinst() {
	einfo "The default init script forces /etc/spreed-webrtc/spreed-webrtc.ini to exist."
	einfo "If you symlink the init script to another one, say spreed-webrtc.foo"
	einfo "then that uses /etc/spreed-webrtc/foo.ini instead."
	einfo
	einfo "Example:"
	einfo "   cd /etc/init.d"
	einfo "   ln -s spreed-webrtc spreed-webrtc.foo"
	einfo "You can now treat spreed-webrtc.foo like any other service"
}
