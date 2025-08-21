/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.errors.error;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

class DOutputEngineError : DError {
  mixin(ErrorThis!("OutputEngine"));
}

mixin(ErrorCalls!("OutputEngine"));

unittest {
  assert(testError(new DOutputEngineError));
}
