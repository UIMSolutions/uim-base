/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.errors.exceptions.unnknowneditor;

import uim.errors;
mixin(ShowModule!());

@safe:

class DUnknownEditorException : Exception {
  this(string message, string fileName = null, ulong lineNumber = 0, Throwable nextInChain = null) {
    super(message, fileName, lineNumber, nextInChain);
  }
}

auto UnknownEditorException() {
  return new DInvalidArgumentException("Unknown Editor");
}

auto UnknownEditorException(string message) {
  return new DInvalidArgumentException(message);
}

unittest {
  auto exception = new DUnknownEditorException();
  assert(exception !is null, "Failed to create DUnknownEditorException instance");

  assert(testException(exception), "Test for DUnknownEditorException failed");
}