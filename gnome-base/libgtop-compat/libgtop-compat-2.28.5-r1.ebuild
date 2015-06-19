# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"
GNOME_ORG_MODULE=libgtop

inherit gnome2

DESCRIPTION="A library that provides top functionality to applications"
HOMEPAGE="http://developer.gnome.org/libgtop/stable/"

LICENSE="GPL-2"
SLOT="2.7" # libgtop soname version
KEYWORDS="alpha amd64 ~arm ia64 ~mips ppc ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.6:2"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.4
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	!<gnome-base/libgtop-2.30.0
"

src_configure() {
	DOCS="AUTHORS ChangeLog NEWS README"
	gnome2_src_configure \
		--disable-static \
		--disable-introspection
}

src_install() {
	gnome2_src_install
	cd "${ED}"
	find usr -mindepth 1 -maxdepth 1 -name "$(get_libdir)" -prune -o -print | xargs rm -r || die
	find "usr/$(get_libdir)" -mindepth 1 -maxdepth 1 \( -type d -o -name '*.so' \) -print | xargs rm -r || die
}
