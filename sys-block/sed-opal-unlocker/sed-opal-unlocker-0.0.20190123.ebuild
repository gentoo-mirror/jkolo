EAPI=6

inherit linux-info

DESCRIPTION="Micro-utility for unlocking TCG-OPAL encrypted disks, utilizing CONFIG_BLK_SED_OPAL interface introduced in kernel 4.11."
HOMEPAGE="https://github.com/dex6/sed-opal-unlocker"
SRC_URI="https://github.com/dex6/sed-opal-unlocker/archive/8ef88c017a63aa24823651f38ea442997a0dc419.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CONFIG_CHECK="~BLK_SED_OPAL"

S="${WORKDIR}/sed-opal-unlocker-8ef88c017a63aa24823651f38ea442997a0dc419"

src_install() {
        dosbin sed-opal-unlocker sedutil-passhasher.py
}
