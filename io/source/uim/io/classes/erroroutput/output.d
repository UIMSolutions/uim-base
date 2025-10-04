/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.error.output;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

class DErrorOutput : DOutput {
  static private DErrorOutput _output;
  static DErrorOutput output() {
    if (_output is null) {
      _output = new DErrorOutput();
    }
    return _output;
  }

  this() {
    name = "ErrorOutput";
  }

  IErrorOutputEngine engine() {
    return new DErrorOutputEngine();
  }

  
}

auto ErrorOutput() {
  return DErrorOutput.output();
}
