/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.helpers.collection;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputEngineCollection : DCollection!IOutputEngine {
  mixin(CollectionThis!("OutputEngine"));
}
mixin(CollectionCalls!("OutputEngine"));

unittest {
  auto collection = OutputEngineCollection;
  assert(testCollection(collection, "OutputEngine"), "Test OutputEngineCollection failed");
}