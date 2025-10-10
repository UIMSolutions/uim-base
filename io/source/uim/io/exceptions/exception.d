/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.exceptions.exception;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

// Exception class for Console libraries. This exception will be thrown from Console library classes when they encounter an error.
class DConsoleException : DException {
  // mixin(ExceptionThis!("Console"));

  protected int _defaultCode; // = DCommand.false;
  protected int _exceptionCode;
  protected Throwable _previousException;

/*   this(
    string message, int exceptionCode = 0, Throwable previousException = null
  ) {
    super(message);
    _exceptionCode = exceptionCode;
    _previousException = previousException;
  } */
}

/* 
mixin(ExceptionCalls!("Console"));

unittest {
  testException(ConsoleException);
}
*/

unittest {
  auto exception = new DConsoleException();
  assert(exception !is null, "Failed to create DConsoleException instance");

  assert(testException(exception), "Test for DConsoleException failed");
}