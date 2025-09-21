/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.commands.create;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DCreateOutputEngineCommand : DOutputCommand {
  mixin(CommandThis!("CreateOutputEngine"));

  override bool execute(Json[string] options) {
    // Creating engine using factory
    auto factory = OutputEngineFactory();
    if (factory is null) {
      Error("Output engine factory is not set or invalid.", __MODULE__);
      return false;
    }

    if (!options.has("name")) {
      Error("Missing required parameter: name", __MODULE__);
      return false;
    }

    auto engine = factory.createEngine(options.getString("name"));
    if (engine is null) {
      Error("Failed to create output engine.", __MODULE__);
      return false;
    }

    // Registering engine in registry
    auto registry = OutputEngineRegistry();
    if (registry is null) {
      Error("Output engine registry is not set or invalid.", __MODULE__);
      return false;
    }

    if (!options.has("name-in-registry")) {
      Error("Missing required parameter: name-in-registry", __MODULE__);
      return false;
    }

    auto response = registry.register(options.getString("name-in-registry"), engine);
    if (!response) {
      Error("Failed to register output engine.", __MODULE__);
      return false;
    }

    return true;
  }
}

mixin(CommandCalls!("CreateOutputEngine"));

unittest {
  assert(testCommand(new DCreateOutputEngineCommand));
}
