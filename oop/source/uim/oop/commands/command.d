/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.commands.command;

mixin(Version!"test_uim_oop");

import uim.oop;
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
  bool execute(Json options) {
    return execute(options.get!(Json[string]));
  }

  bool execute(string[string] options) {
    return execute(options.toJsonMap);
  }
  
  abstract bool execute(Json[string] options = null);
}
