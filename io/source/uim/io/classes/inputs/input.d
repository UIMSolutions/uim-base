/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.inputs.input;

import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DInput : UIMObject {
  this() {
    super();
  }

  protected IInputEngine[string] _engines;
  protected IInputEngine[string] engines() {
    if (_engines is null) {
      _engines = new DInputEngine[string];
    }
    return _engines;
  }

  static IInput _input;
  static IInput input() {
    if (_input is null) {
      _input = new DInput;

    }
    return _input;
  }
}
