# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
EGO_PN=github.com/grahamedgecombe/ct-submit

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	ARCHIVE_URI="https://github.com/grahamedgecombe/ct-submit/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="A program for submitting X.509 certificate chains to Certificate Transparency log servers."
HOMEPAGE="https://github.com/grahamedgecombe/ct-submit"
SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
IUSE=""

src_install() {
	dobin ct-submit
	dodoc src/${EGO_PN}/{README.markdown,LICENSE}
}
