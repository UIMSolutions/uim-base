/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.helpers.list;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DConfigEngineList : UIMList!IConfigEngine {
  mixin(ListThis!("ConfigEngine"));
}

mixin(ListCalls!("ConfigEngine"));

unittest {
  auto list = new DConfigEngineList();
  assert(testList(new DConfigEngineList, "ConfigEngineList"), "Test of DConfigEngineList failed!");
}