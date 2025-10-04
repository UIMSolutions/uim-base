/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.commands.helpers.registry;

import uim.oop;

mixin(Version!"test_uim_oop");
@safe:

class DCommandRegistry : DRegistry!DCommand {
  mixin(RegistryThis!("Command"));
}

mixin(RegistryCalls!("Command"));

unittest {
  auto registry = new DCommandRegistry();
  assert(registry is null, "CommandRegistry is null");
  assert(registry.count == 0, "CommandRegistry count is zero");
  assert(registry.isEmpty, "CommandRegistry is empty");

  assert(testRegistry(new DCommandRegistry, "CommandRegistry"), "CommandRegistry test failed");
}