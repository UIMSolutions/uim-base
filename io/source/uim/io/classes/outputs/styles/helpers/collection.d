/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.styles.helpers.collection;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputStyleCollection : DCollection!IOutputStyle {
  mixin(CollectionThis!("OutputStyle"));
}
mixin(CollectionCalls!("OutputStyle"));

unittest {
  auto collection = OutputStyleCollection;
  assert(testCollection(collection, "OutputStyle"), "Test OutputStyleCollection failed");
}