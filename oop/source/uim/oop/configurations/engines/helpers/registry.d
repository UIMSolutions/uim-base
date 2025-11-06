/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.helpers.registry;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DConfigEngineRegistry : DRegistry!DConfigEngine {
  mixin(RegistryThis!("ConfigEngine"));
}

mixin(RegistryCalls!("ConfigEngine"));

unittest {
  auto registry = new DConfigEngineRegistry();
  assert(testRegistry(new DConfigEngineRegistry, "DConfigEngineRegistry"), "Test of DConfigEngineRegistry failed!");
}