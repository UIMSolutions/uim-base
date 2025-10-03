/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.helpers.registry;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DOutputFormatterRegistry : DObjectRegistry!IOutputFormatter {
  mixin(RegistryThis!"OutputFormatter");
}

mixin(RegistryCalls!"OutputFormatter");

unittest {
  auto registry = new DOutputFormatterRegistry();
  assert(registry !is null, "OutputFormatterRegistry is null!");

  assert(testRegistry(registry, "OutputFormatter"), "OutputFormatterRegistry test failed!");
}

