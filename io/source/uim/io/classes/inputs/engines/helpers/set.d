/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.inputs.engines.helpers.set;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DInputEngineSet : UIMSet!IInputEngine {
  mixin(SetThis!("InputEngine"));
}
mixin(SetCalls!("InputEngine"));

unittest {
  auto set = InputEngineSet;
  assert(testSet(set, "InputEngine"), "Test InputEngineSet failed");
}