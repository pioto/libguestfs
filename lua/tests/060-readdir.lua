#!/usr/bin/lua
-- libguestfs Lua bindings -*- lua -*-
-- Copyright (C) 2012 Red Hat Inc.
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

require "guestfs"

local g = Guestfs.create ()

file = io.open ("test.img", "w")
file:seek ("set", 10 * 1024 * 1024)
file:write (' ')
file:close ()

g:add_drive ("test.img")

g:launch ()

g:part_disk ("/dev/sda", "mbr")
g:mkfs ("ext2", "/dev/sda1")
g:mount ("/dev/sda1", "/")
g:mkdir ("/p")
g:touch ("/q")

local dirs = g:readdir ("/")

function print_dirs(dirs)
   for i,dentry in ipairs (dirs) do
      for k,v in pairs (dentry) do
         print(i, k, v)
      end
   end
end

print_dirs (dirs)
table.sort (dirs, function (a,b) return a["name"] < b["name"] end)
print_dirs (dirs)

-- Slots 1, 2, 3 contain "." and ".." and "lost+found" respectively.

if (dirs[4]["name"] ~= "p") then
   error "incorrect name in slot 4"
end
if (dirs[5]["name"] ~= "q") then
   error "incorrect name in slot 5"
end

g:shutdown ()

g:close ()

os.remove ("test.img")
