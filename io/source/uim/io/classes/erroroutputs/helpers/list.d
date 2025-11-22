/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.helpers.list;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DErrorOutputList : UIMList!IErrorOutput {
  mixin(ListThis!("ErrorOutput"));
}
mixin(ListCalls!("ErrorOutput"));

unittest {
  auto list = ErrorOutputList;
  assert(testList(list, "ErrorOutput"), "Test ErrorOutputList failed");
}