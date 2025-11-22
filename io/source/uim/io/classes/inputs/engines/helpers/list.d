/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.inputs.engines.helpers.list;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DInputEngineList : DList!IInputEngine {
  mixin(ListThis!("InputEngine"));
}
mixin(ListCalls!("InputEngine"));

unittest {
  auto list = InputEngineList;
  assert(testList(list, "InputEngine"), "Test InputEngineList failed");
}