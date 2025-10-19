/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.helpers.factory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputEngineFactory : DFactory!IOutputEngine {
  mixin(FactoryThis!"OutputEngine");
}
mixin(FactoryCalls!"OutputEngine");

unittest {
  auto factory = new DOutputEngineFactory();
  assert(testFactory(factory, "OutputEngine"), "Test of DOutputFactory failed!");
}