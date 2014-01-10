# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hike/hike-1.2.3-r1.ebuild,v 1.1 2013/12/27 03:26:54 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Hike is a Ruby library for finding files in a set of paths."
HOMEPAGE="https://github.com/sstephenson/hike"
LICENSE="MIT"
SRC_URI="https://github.com/sstephenson/hike/archive/v${PV}.tar.gz -> ${P}.tgz"

KEYWORDS="~amd64 ~arm ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

src_prepare() {
	rm test/fixtures/app/views/.#application.js.coffee.erb
	rm test/fixtures/app/views/.#index.html.erb
	rm test/fixtures/app/views/.application.js.coffee.erb.swp
	rm test/fixtures/app/views/.index.html.erb.swp
	rm test/fixtures/app/views/index.html.erb~
}

each_ruby_test() {
	${RUBY} -Ilib:test -S testrb test || die
}
