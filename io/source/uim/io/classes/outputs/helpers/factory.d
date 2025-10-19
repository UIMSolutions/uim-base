/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.helpers.factory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputFactory : DFactory!IOutput {
  mixin(FactoryThis!("Output"));
}

mixin(FactoryCalls!("Output"));

unittest {
  auto factory = new DOutputFactory();
  assert(testFactory(factory, "Output"), "Test OutputFactory failed");
}
