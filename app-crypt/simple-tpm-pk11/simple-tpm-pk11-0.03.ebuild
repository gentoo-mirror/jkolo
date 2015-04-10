# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A simple library for using the TPM chip to secure SSH keys."
HOMEPAGE="https://github.com/ThomasHabets/simple-tpm-pk11"
SRC_URI="https://github.com/ThomasHabets/simple-tpm-pk11/archive/${PV}.tar.gz"

LICENSE="APACHE-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="mirror"
#DEPEND="dev-util/gtk-doc"

inherit autotools
#flag-o-matic

src_prepare() {
    # Remove problematic LDFLAGS declaration
    # sed -i -e 's/ -Werror//g' src/Makefile.am || die
    #filter-flags -Wall
    #strip-flags
    #append-flags -Wno-error
    eautoreconf
}

#src_unpack() {
    #unpack ${A}
    #mv "simple-tpm-${P}" "${P}"
#}
