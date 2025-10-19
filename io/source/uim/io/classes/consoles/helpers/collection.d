/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.consoles.helpers.collection;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DConsoleCollection : DCollection!IConsole {
  mixin(CollectionThis!("Console"));
}
mixin(CollectionCalls!("Console"));

unittest {
  auto collection = ConsoleCollection;
  assert(testCollection(collection, "Console"), "Test ConsoleCollection failed");
}