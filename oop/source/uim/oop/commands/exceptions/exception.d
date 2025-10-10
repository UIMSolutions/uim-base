/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.commands.exceptions.exception;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

// Base commands exception.
class DCommandException : DException {
  mixin(ExceptionThis!("Command"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    messageTemplate("default", "Exception uim.oop.exceptions");

    return true;
  }
}

mixin(ExceptionCalls!("Command"));

unittest {
  auto exception = new DCommandException();
  assert(exception !is null, "Failed to create DCommandException instance");

  assert(testException(exception), "Test for DCommandException failed");
}