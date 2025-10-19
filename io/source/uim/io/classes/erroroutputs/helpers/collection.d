/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.helpers.collection;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DErrorOutputCollection : DCollection!IErrorOutput {
  mixin(CollectionThis!("ErrorOutput"));
}
mixin(CollectionCalls!("ErrorOutput"));

unittest {
  auto collection = ErrorOutputCollection;
  assert(testCollection(collection, "ErrorOutput"), "Test ErrorOutputCollection failed");
}