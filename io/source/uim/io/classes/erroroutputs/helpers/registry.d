/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.erroroutputs.helpers.registry;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DErrorOutputRegistry : DObjectRegistry!IErrorOutput {
  mixin(RegistryThis!"ErrorOutput");
}

mixin(RegistryCalls!"ErrorOutput");

unittest {
  auto registry = new DErrorOutputRegistry();
  assert(registry !is null, "ErrorOutputRegistry is null!");

  assert(testRegistry(registry, "ErrorOutput"), "ErrorOutputRegistry test failed!");
}

