/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.helpers.list;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputEngineList : UIMList!IOutputEngine {
  mixin(ListThis!("OutputEngine"));
}
mixin(ListCalls!("OutputEngine"));

unittest {
  auto list = OutputEngineList;
  assert(testList(list, "OutputEngine"), "Test OutputEngineList failed");
}