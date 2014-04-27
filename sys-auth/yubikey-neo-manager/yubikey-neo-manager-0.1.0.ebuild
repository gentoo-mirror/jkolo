# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/ykpers/ykpers-1.14.1.ebuild,v 1.1 2013/10/28 13:50:08 zerochaos Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

DESCRIPTION="Library and tool for personalization of Yubico's YubiKey NEO"
SRC_URI="http://opensource.yubico.com/yubikey-neo-manager/releases/${P}.tar.gz"
HOMEPAGE="http://opensource.yubico.com/yubikey-neo-manager"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="BSD-2"

inherit distutils-r1

RDEPEND="sys-auth/libykneomgr
	 sys-auth/ykpers
	 dev-python/pyside
	 dev-python/nose"

DEPEND="${RDEPEND}"

src_install()
{
	distutils-r1_src_install
	doman scripts/neoman.1 || die
	domenu resources/neoman.desktop || die
	doicon resources/neoman.xpm || die
}