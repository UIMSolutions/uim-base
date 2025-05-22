module uim.errors.exceptions.invalidargument;

mixin(Version!("test_uim_errors"));

import uim.errors;

@safe:

class DInvalidArgumentException : Exception {
  this(string message, string fileName, ulong lineNumber, Throwable nextInChain) {
    super(message, fileName, lineNumber, nextInChain);
  }
}

auto InvalidArgumentException() {
  return new DInvalidArgumentException("Invalid Argumnent");
}

auto InvalidArgumentException(string message) {
  return new DInvalidArgumentException(message);
}
