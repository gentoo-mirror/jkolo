EAPI="8"

PHP_EXT_NAME="pdlib"
USE_PHP="php8-1 php8-2 php8-3 php8-4"

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
