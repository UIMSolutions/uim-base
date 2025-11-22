/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.consoles.helpers.list;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DConsoleList : UIMList!IConsole {
  mixin(ListThis!("Console"));
}
mixin(ListCalls!("Console"));

unittest {
  auto list = ConsoleList;
  assert(testList(list, "Console"), "Test ConsoleList failed");
}