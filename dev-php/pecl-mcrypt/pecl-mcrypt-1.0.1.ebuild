EAPI=6

PHP_EXT_NAME="mcrypt"
USE_PHP="php7-2"

inherit php-ext-pecl-r3

DESCRIPTION="mcrypt for php 7.2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
    dev-libs/libmcrypt
"
DEPEND="${RDEPEND}"
