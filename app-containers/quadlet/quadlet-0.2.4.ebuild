EAPI=8
inherit meson

DESCRIPTION="Quadlet is an opinionated tool for easily running podman system containers under systemd in an optimal way."
HOMEPAGE="https://github.com/containers/quadlet"

SRC_URI="https://github.com/containers/${PN}/releases/download/${PV}/${P}.tar.xz"
KEYWORDS="amd64 ~arm ~arm64 ~riscv x86"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="sys-apps/systemd"
RDEPEND="
	${DEPEND}
	app-containers/crun
	app-shells/bash
"

BDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/sh_path.patch" )

