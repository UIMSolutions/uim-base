/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.engines.helpers.factory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DErrorOutputEngineFactory : DFactory!DErrorOutput {
  mixin(FactoryThis!("ErrorOutputEngine"));
}
mixin(FactoryCalls!("ErrorOutputEngine"));

unittest {
  auto factory = new DErrorOutputEngineFactory();
  assert(testFactory(factory, "ErrorOutputEngine"), "Test of DErrorOutputEngineFactory failed!");
}
