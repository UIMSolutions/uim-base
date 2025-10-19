/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.helpers.registry;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputRegistry : DRegistry!IOutput {
  mixin(RegistryThis!("Output"));
}
mixin(RegistryCalls!("Output"));

unittest {
  auto registry = new DOutputRegistry();
  assert(testRegistry(registry, "Output"), "Test OutputRegistry failed");
}