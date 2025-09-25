/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.commands.addengine;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DAddEngineOutputCommand : DOutputCommand {
  mixin(CommandThis!("AddEngineOutput"));

  override bool execute(Json[string] options) {
    auto output = Output();
    if (output is null) {
      Error("Output is not set or invalid.", __MODULE__);
      return false;
    }

    auto registry = OutputEngineRegistry();
    if (registry is null) {
      Error("Output engine registry is not set or invalid.", __MODULE__);
      return false;
    }

    if (!options.hasKey("name")) {
      Error("Missing required parameter: name", __MODULE__);
      return false;
    }

    auto engine = registry.getEngine(options.getString("name"));
    if (engine is null) {
      Error("Output engine not found.", __MODULE__);
      return false;
    }

    auto response = output.addEngine(engine);
    if (!response) {
      Error("Failed to add output engine.", __MODULE__);
      return false;
    }

    return true;
  }
}

mixin(CommandCalls!("AddEngineOutput"));

unittest {
  assert(testCommand(new DAddEngineOutputCommand));
}
