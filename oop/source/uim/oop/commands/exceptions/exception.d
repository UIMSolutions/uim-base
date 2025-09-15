/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.classes.commands.exceptions.exception;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

// Base commands exception.
class DCommandsException : DException {
  mixin(ExceptionThis!("Commands"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    messageTemplate("default", "Exception uim.oop.exceptions");

    return true;
  }
}

mixin(ExceptionCalls!("Commands"));

unittest {
  testException(CommandsException);
}
