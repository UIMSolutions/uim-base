module uim.errors.exceptions.unnknowneditor;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

class DInvalidArgumentException : Exception {
  this(string message, string fileName = null, ulong lineNumber = 0, Throwable nextInChain = null) {
    super(message, fileName, lineNumber, nextInChain);
  }
}

auto UnknownEditorException() {
  return new DInvalidArgumentException("Invalid Argumnent");
}

auto UnknownEditorException(string message) {
  return new DInvalidArgumentException(message);
}
