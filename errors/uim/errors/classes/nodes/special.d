/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.nodes.special;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:

// Debug node for special messages like errors or recursion warnings.
class DSpecialErrorNode : DErrorNode {
  mixin(ErrorNodeThis!("Special"));

  this(Json value) {
    _data = value;
  }

  protected Json _data;
    Json data() {
        return _data;
    }
    
    IErrorNode data(Json newData) {
        _data = newData;
        return this;
    }
}
