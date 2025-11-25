/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.helpers.set;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputEngineSet : UIMSet!IOutputEngine {
  mixin(SetThis!("OutputEngine"));
}
mixin(SetCalls!("OutputEngine"));

unittest {
  auto set = OutputEngineSet;
  assert(testSet(set, "OutputEngine"), "Test OutputEngineSet failed");
}