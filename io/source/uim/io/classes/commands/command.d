/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.commands.command;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

// Base class for commands
class DCommand : UIMObject, ICommand {
  mixin(CommandThis!());
  /*    mixin TLocatorAware;
    mixin TLog; */

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    return true;
  }

  // Execute command with given options.
  abstract bool execute(string[string] options);
  abstract bool execute(Json[string] options);
  abstract bool execute(Json options);
}
