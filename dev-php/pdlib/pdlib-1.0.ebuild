EAPI="7"

PHP_EXT_NAME="pdlib"
USE_PHP="php7-2 php7-3 php7-4"

inherit php-ext-source-r3

DESCRIPTION="PHP bindings for dlib"
HOMEPAGE="https://github.com/goodspb/${PN}"
SRC_URI="https://github.com/goodspb/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="sci-libs/dlib[X]"
DEPEND="${RDEPEND}"

RESTRICT="test"
