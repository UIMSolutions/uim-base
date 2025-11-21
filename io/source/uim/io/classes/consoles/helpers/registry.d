/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.consoles.helpers.registry;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

class DConsoleRegistry : DRegistry!IConsole {
  mixin(RegistryThis!"Console");
}
mixin(RegistryCalls!"Console");

unittest {
  auto registry = ConsoleRegistry();
  assert(testRegistry(registry, "Console"), "ConsoleRegistry test failed!");
}
