/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.inputs.engines.helpers.factory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DInputFactory : DFactory!IInput {
  mixin(FactoryThis!("Input"));
}
Calls!("Input"));

unittest {
  auto factory = new DInputFactory();
  assert(testFactory(factory, "Input"), "Test of DInputFactory failed!");
}
