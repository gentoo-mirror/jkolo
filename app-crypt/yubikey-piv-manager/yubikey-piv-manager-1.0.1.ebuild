# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="The YubiKey PIV Manager enables you to configure a PIV-enabled YubiKey through a graphical user interface."
HOMEPAGE="https://developers.yubico.com/yubikey-piv-manager/"
SRC_URI="https://developers.yubico.com/yubikey-piv-manager/Releases/yubikey-piv-manager-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="mirror"
DEPEND="dev-python/pyside
        dev-python/pycrypto
        app-crypt/yubico-piv-tool"

#inherit autotools
#flag-o-matic

src_compile() {
    python setup.py build
}

src_install() {
    python setup.py install --root=${D}
}