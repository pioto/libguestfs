# libguestfs
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

TESTS = \
	test-charset-fidelity

TESTS_ENVIRONMENT = $(top_builddir)/run --test $(VG)

check_PROGRAMS = $(TESTS)

test_charset_fidelity_SOURCES = test-charset-fidelity.c
test_charset_fidelity_CPPFLAGS = \
	-I$(top_srcdir)/src -I$(top_builddir)/src
test_charset_fidelity_CFLAGS = \
	$(WARN_CFLAGS) $(WERROR_CFLAGS)
test_charset_fidelity_LDADD = \
	$(top_builddir)/src/libutils.la \
	$(top_builddir)/src/libguestfs.la \
	$(LIBXML2_LIBS) \
	$(LIBVIRT_LIBS)
