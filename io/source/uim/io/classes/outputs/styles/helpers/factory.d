/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.styles.helpers.factory;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputStyleFactory : DFactory!IOutputStyle {
    mixin(FactoryThis!("OutputStyle"));
}
mixin(FactoryCalls!("OutputStyle"));

unittest {
  auto factory = new DOutputStyleFactory();
  assert(factory !is null, "OutputStyleFactory is null");

  assert(testFactory(factory, "OutputStyle"), "Test OutputStyleFactory failed");
}