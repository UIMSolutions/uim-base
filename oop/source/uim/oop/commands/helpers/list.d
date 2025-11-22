/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.commands.helpers.list;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DCommanUIMList : UIMList!ICommand {
  mixin(ListThis!("Command"));
}

mixin(ListCalls!("Command"));

unittest {
  auto list = new DCommanUIMList();
  assert(testList(list, "CommanUIMList"), "Test of DCommanUIMList failed!");
}