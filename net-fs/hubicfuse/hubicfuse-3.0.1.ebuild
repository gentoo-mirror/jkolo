# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic

DESCRIPTION="Support for mounting HubiC drive in GNU/Linux"
HOMEPAGE="https://github.com/TurboGit/${PN}"
SRC_URI="https://github.com/TurboGit/${PN}/archive/v${PV}.zip"
SLOT="0"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="libressl"

DEPEND="
	net-misc/curl
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	>=sys-fs/fuse-2.8.6
	sys-apps/file
	dev-libs/libxml2
	dev-libs/json-c
"
RDEPEND="${DEPEND}"

DOCS=( README.md )

src_install() {
	default

	dobin hubic_token
}
