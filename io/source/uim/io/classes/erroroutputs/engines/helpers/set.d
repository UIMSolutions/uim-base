/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.engines.helpers.set;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DErrorOutputEngineSet : DSet!DErrorOutputEngine {
  mixin(SetThis!("ErrorOutputEngine"));
}
mixin(SetCalls!("ErrorOutputEngine"));

unittest {
  auto set = ErrorOutputEngineSet();
  assert(testSet(set, "ErrorOutputEngine"), "ErrorOutputEngineSet failed");
}
