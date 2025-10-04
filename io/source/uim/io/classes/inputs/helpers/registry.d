/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.inputs.helpers.registry;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputFormatterRegistry : DRegistry!IOutputFormatter {
  mixin(RegistryThis!("OutputFormatter"));
}

mixin(RegistryCalls!("OutputFormatter"));

unittest {
  auto registry = new DOutputFormatterRegistry();
  assert(registry !is null, "Creation of OutputFormatterRegistry failed!");

  assert(testRegistry(registry, "OutputFormatter"), "Test of OutputFormatterRegistry failed!");
}
