/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.helpers.collection;

import uim.oop;

mixin(Version!"test_uim_oop");
@safe:

class DCommandCollection : DCollection!ICommand {
  mixin(CollectionThis!("Command"));
}

mixin(CollectionCalls!("Command"));

unittest {
  auto collection = new DCommandCollection();
  assert(testCollection(new DCommandCollection, "CommandCollection"), "Test of DCommandCollection failed!");
}