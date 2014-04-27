# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libyubikey/libyubikey-1.10.ebuild,v 1.2 2013/04/22 13:22:12 zerochaos Exp $

EAPI=5

inherit eutils

DESCRIPTION="Yubico C low-level library"
HOMEPAGE="https://github.com/Yubico/yubico-c"
SRC_URI="http://opensource.yubico.com/libykneomgr/releases/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="BSD-2"
BACKENDS="gpshell pcsc-lite"
IUSE="${BACKENDS} static-libs"
REQUIRED_USE="^^ ( ${BACKENDS} )"
DOCS=( AUTHORS COPYING ChangeLog INSTALL NEWS README )

src_configure() {
    if use pcsc-lite; then
	BACKEND="pcsc"
    elif use gpshell; then
	BACKEND="gpshell"
    else
	die "Unknown backend"
    fi
    
    econf --with-backend=${BACKEND}
}
