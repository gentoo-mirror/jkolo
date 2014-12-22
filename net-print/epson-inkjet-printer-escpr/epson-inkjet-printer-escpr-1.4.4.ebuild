# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_P="${P}-1lsb3.2"

DESCRIPTION="Epson Inkjet Printer Driver (ESC/P-R) for Linux"
HOMEPAGE="http://avasys.jp/eng/linux_driver/download/lsb/epson-inkjet/escpr/"
SRC_URI="https://download3.ebz.epson.net/dsc/f/03/00/03/29/49/36201e41f124a1f4f7b793533b1ade1202032276/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"
