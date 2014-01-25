EAPI=5

inherit base eutils

DESCRIPTION="AbiWord file processor format import filter library"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/libabw/"
SRC_URI="http://dev-www.libreoffice.org/src/${P}.tar.xz"

LICENSE="|| ( LGPL-2.1 MPL-2.0 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="doc debug static-libs"

RDEPEND="
	app-text/libwpd:0.9
	dev-libs/boost
	dev-libs/libxml2
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

src_configure() {
	econf \
		--disable-werror \
		$(use_enable static-libs static) \
		--docdir=/usr/share/doc/${PF} \
		$(use_with doc docs) \
		$(use_enable debug)
}

src_install() {
	default
	prune_libtool_files --all
}
