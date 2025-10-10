/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.exceptions.exception;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

class DOutputEngineException : DException {
  mixin(ExceptionThis!("OutputEngine"));
}

mixin(ExceptionCalls!("OutputEngine"));

unittest {
  auto exception = new DOutputEngineException();
  assert(exception !is null, "Failed to create DOutputEngineException instance");

  assert(testException(exception), "Test for DOutputEngineException failed");
}