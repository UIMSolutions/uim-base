/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.double_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
mixin(CheckJsonIs!("Double"));

bool isDouble(Json value, string key) {
  return value.hasKey(key) 
    ? value[key].isDouble 
    : false;
}

bool isDouble(Json value) {
  return (value.type == Json.Type.float_);
}

unittest {
  writeln("bool isDouble(Json value)");
  assert(!Json(true).isDouble);  
  assert(!Json(10).isDouble);  
  assert(Json(1.1).isDouble);  
  assert(!Json("text").isDouble);
}
// #endregion is

// #region get
double getDouble(Json value, string key, bool strict = true) {
  return !value.isNull && value.isObject && value.hasKey(key)
    ? value[key].getDouble(strict) : 0.0;
}

double getDouble(Json value, bool strict = true) {
  if (!strict) {
    if (value.isBoolean) {
      return value.get!bool ? 1.0 : 0.0;
    }
    if (value.isInteger) {
      return to!double(value.get!int);
    }
    if (value.isString) {
      return to!double(value.getString);
    }
  }

  return !value.isNull && (value.isFloat || value.isDouble)
    ? value.get!double : 0.0;
}
// #endregion get

// #region only
// #endregion only
