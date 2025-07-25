/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.commands.exceptions.exception;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

// Base commands exception.
class DCommandsException : DException {
  mixin(ExceptionThis!("Commands"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    messageTemplate("default", "Exception in libary uim-commands");

    return true;
  }
}

mixin(ExceptionCalls!("Commands"));

unittest {
  testException(CommandsException);
}
