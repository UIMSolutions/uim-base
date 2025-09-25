/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.commands.remove;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DRemoveOutputEngineCommand : DOutputCommand {
  mixin(CommandThis!("RemoveOutputEngine"));

  override bool execute(Json[string] options) {
    // Registering engine in registry
    auto registry = OutputEngineRegistry();
    if (registry is null) {
      Error("Output engine registry is not set or invalid.", __MODULE__);
      return false;
    }

    if (!options.hasKey("name")) {
      Error("Missing required parameter: name", __MODULE__);
      return false;
    }

    auto response = registry.remove(options.getString("name"));
    if (!response) {
      Error("Failed to remove output engine.", __MODULE__);
      return false;
    }

    return true;
  }
}

mixin(CommandCalls!("RemoveOutputEngine"));

unittest {
  assert(testCommand(new DRemoveOutputEngineCommand));
}
