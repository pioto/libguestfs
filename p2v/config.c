/* virt-p2v
 * Copyright (C) 2009-2014 Red Hat Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include <config.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include <unistd.h>
#include <errno.h>
#include <assert.h>
#include <locale.h>
#include <libintl.h>

#include "p2v.h"

struct config *
new_config (void)
{
  struct config *c;

  c = calloc (1, sizeof *c);
  if (c == NULL) {
    perror ("calloc");
    exit (EXIT_FAILURE);
  }

#if FORCE_REMOTE_DEBUG
  c->verbose = 1;
#endif
  c->port = 22;

  return c;
}

struct config *
copy_config (struct config *old)
{
  struct config *c = new_config ();

  memcpy (c, old, sizeof *c);

  /* Need to deep copy strings and string lists. */
  if (c->server)
    c->server = strdup (c->server);
  if (c->username)
    c->username = strdup (c->username);
  if (c->password)
    c->password = strdup (c->password);
  if (c->guestname)
    c->guestname = strdup (c->guestname);
  if (c->disks)
    c->disks = guestfs___copy_string_list (c->disks);
  if (c->removable)
    c->removable = guestfs___copy_string_list (c->removable);
  if (c->interfaces)
    c->interfaces = guestfs___copy_string_list (c->interfaces);

  return c;
}

void
free_config (struct config *c)
{
  free (c->server);
  free (c->username);
  free (c->password);
  free (c->guestname);
  guestfs___free_string_list (c->disks);
  guestfs___free_string_list (c->removable);
  guestfs___free_string_list (c->interfaces);
  free (c);
}
