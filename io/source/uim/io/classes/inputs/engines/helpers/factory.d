/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.inputs.engines.helpers.factory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DInputEngineFactory : DFactory!IInputEngine {
  mixin(FactoryThis!("InputEngine"));
}
mixin(FactoryCalls!("InputEngine"));

unittest {
  auto factory = new DInputEngineFactory();
  assert(testFactory(factory, "InputEngine"), "Test of DInputEngineFactory failed!");
}
