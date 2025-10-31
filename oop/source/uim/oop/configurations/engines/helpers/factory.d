/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.helpers.factory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DConfigEngineFactory : DFactory!IConfigEngine {
  mixin(FactoryThis!("ConfigEngine"));
}
mixin(FactoryCalls!("ConfigEngine"));

unittest {
  auto factory = new DConfigEngineFactory();
  assert(testFactory(factory, "ConfigEngine"), "Test of DConfigEngineFactory failed!");
}
