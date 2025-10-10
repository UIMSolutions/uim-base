/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.inputs.helpers.factory;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DInputFactory : DFactory!IInput {
    mixin(FactoryThis!("Input"));
}
mixin(FactoryCalls!("Input"));

unittest {
  auto factory = new DInputFactory();
  assert(factory !is null, "Creation of InputFactory failed");

  assert(testFactory(factory, "Input"), "Test of InputFactory failed");
}

