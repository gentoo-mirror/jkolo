EAPI=8

PHP_EXT_NAME="krb5"
USE_PHP="php7-4 php8-0 php8-1 php8-2"

inherit php-ext-pecl-r3

DESCRIPTION="krb5 extension"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
    app-crypt/mit-krb5
"
DEPEND="${RDEPEND}"
