/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.commands.removeengine;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DRemoveEngineOutputCommand : DOutputCommand {
  mixin(CommandThis!("RemoveEngineOutput"));

    override bool execute(Json[string] options) {
    auto output = Output();
    if (output is null) {
      Error("Output is not set or invalid.", __MODULE__);
      return false;
    }

    if (!options.hasKey("name")) {
      Error("Missing required parameter: name", __MODULE__);
      return false;
    }

    auto response = output.removeEngine(options.getString("name"));
    if (!response) {
      Error("Failed to remove output engine.", __MODULE__);
      return false;
    }
    
    return true;
  }
}

mixin(CommandCalls!("RemoveEngineOutput"));

unittest {
  assert(testCommand(new DRemoveEngineOutputCommand));
}
