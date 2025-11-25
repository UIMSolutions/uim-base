/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.helpers.set;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DErrorOutputSet : UIMSet!IErrorOutput {
  mixin(SetThis!("ErrorOutput"));
}
mixin(SetCalls!("ErrorOutput"));

unittest {
  auto set = ErrorOutputSet;
  assert(testSet(set, "ErrorOutput"), "Test ErrorOutputSet failed");
}