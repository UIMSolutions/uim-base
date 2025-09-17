/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.commands.exceptions.notcreate;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

// Base commands exception.
class DNotCreateCommandException : DCommandException {
  mixin(ExceptionThis!("NotCreateCommand"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    messageTemplate("default", "Not able to create command '{name}' in '{instance}'");

    return true;
  }
}

mixin(ExceptionCalls!("NotCreateCommand"));

unittest {
  testException(CommandsException);
}
