/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.exceptions.exceptions.errors;

mixin(Version!("test_uim_exceptions"));

import uim.exceptions;
@safe:


// Base error exception.
class DErrorsException : DException {
  mixin(ExceptionThis!("Errors"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    messageTemplate("default", "Exception in libary uim-exceptions");

    return true;
  }
}

mixin(ExceptionCalls!("Errors"));

unittest {
  testException(ErrorsException);
}
