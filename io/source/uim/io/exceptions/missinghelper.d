/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.exceptions.missinghelper;

import uim.io;
@safe:

mixin(Version!"test_uim_io");

import uim.io;
@safe:


// Used when a Helper cannot be found.
class DMissingHelperException : DConsoleException {
  // mixin(ExceptionThis!("MissingHelper"));

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    messageTemplate("default", "Helper class '%s' could not be found.");

    return true;
  }
}

mixin(ExceptionCalls!("MissingHelper"));

unittest {
  testException(MissingHelperException);
}
