# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils flag-o-matic

DESCRIPTION="CryFS encrypts your files, so you can safely store them anywhere. It works well together with cloud services like Dropbox, iCloud, OneDrive and others."
HOMEPAGE="https://www.cryfs.org"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.zip"
SLOT="0"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="libressl"


DEPEND="
	net-misc/curl
	>=dev-libs/boost-1.56.0[threads]
	>=dev-libs/crypto++-5.6.3
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	>=sys-fs/fuse-2.8.6
	dev-lang/python:2.7
"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog.txt README.md )

PATCHES=( "${FILESDIR}/ndebug.patch" )

CMAKE_BUILD_TYPE=Release
