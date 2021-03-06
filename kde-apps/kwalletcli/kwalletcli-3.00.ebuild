# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A command-line interface for the KDE Wallet"
HOMEPAGE="https://www.mirbsd.org/kwalletcli.htm"
SRC_URI="https://www.mirbsd.org/MirOS/dist/hosted/${PN}/${P}.tar.gz"

# TODO: add MirOS License?
LICENSE="LGPL-3+"
SLOT="5"
KEYWORDS=" ~amd64 ~x86"

RDEPEND="
    app-shells/mksh
    kde-frameworks/kwallet:5
"
DEPEND="${RDEPEND}
    virtual/pkgconfig"

S="${WORKDIR}/${PN}"

append-flags -fPIC

src_prepare() {
    sed -i \
	-e "s:-lQtCore:$($(tc-getPKG_CONFIG) --libs QtCore):" \
	GNUmakefile || die 'sed on GNUmakefile failed'
	
    eapply_user
}

src_compile() {
    tc-export CC CXX
    emake KDE_VER=5
}

src_install() {
    # Workaround for broken install script
    dodir /usr/bin /usr/share/man/man1

    emake DESTDIR="${D}" INSTALL_STRIP= install
}
