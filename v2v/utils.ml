(* virt-v2v
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
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *)

(* Utilities used in virt-v2v only. *)

open Printf

open Common_gettext.Gettext
open Common_utils

open Types

let prog = Filename.basename Sys.executable_name
let error ?exit_code fs = error ~prog ?exit_code fs

let quote = Filename.quote

(* Quote XML <element attr='...'> content.  Note you must use single
 * quotes around the attribute.
 *)
let xml_quote_attr str =
  let str = Common_utils.replace_str str "&" "&amp;" in
  let str = Common_utils.replace_str str "'" "&apos;" in
  let str = Common_utils.replace_str str "<" "&lt;" in
  let str = Common_utils.replace_str str ">" "&gt;" in
  str

external drive_name : int -> string = "v2v_utils_drive_name"

