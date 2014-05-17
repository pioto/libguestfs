# libguestfs virt-p2v ISO
# Copyright (C) 2009-2014 Red Hat Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

include $(top_srcdir)/subdir-rules.mk

EXTRA_DIST = \
	README \
	issue \
	launch-virt-p2v.in \
	p2v.service \
	virt-builder-target.sh.in

# You need to read the README file before trying any of these targets.

virt-builder-target: virt-builder-target.sh launch-virt-p2v
	srcdir=$(srcdir) $(top_builddir)/run ./virt-builder-target.sh

# Deal with stupid autotools libexecdir-not-expandable crap.
launch-virt-p2v: launch-virt-p2v.in
	rm -f $@ $@-t
	sed 's,@''libexecdir@,$(libexecdir),g' < $< > $@-t
	chmod 0555 $@-t
	mv $@-t $@