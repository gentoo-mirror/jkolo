EAPI=6

PHP_EXT_NAME="krb5"
USE_PHP="php5-6 php7-0 php7-1 php7-2"

inherit php-ext-pecl-r3

DESCRIPTION="krb5 extension"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
    app-crypt/mit-krb5
"
DEPEND="${RDEPEND}"
