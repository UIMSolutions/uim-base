/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.exceptions.invalidargument;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

class DInvalidArgumentException : Exception {
  this(string message, string fileName = null, ulong lineNumber = 0, Throwable nextInChain = null) {
    super(message, fileName, lineNumber, nextInChain);
  }
}

auto InvalidArgumentException() {
  return new DInvalidArgumentException("Invalid Argumnent");
}

auto InvalidArgumentException(string message) {
  return new DInvalidArgumentException(message);
}
