/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.inputs.engines.helpers.registry;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DInputEngineRegistry : DRegistry!IInputEngine {
  mixin(RegistryThis!"InputEngine");
}

mixin(RegistryCalls!"InputEngine");

unittest {
  auto registry = new DInputEngineRegistry();
  assert(testRegistry(registry, "InputEngine"), "Test for InputEngineRegistry failed!");
}
