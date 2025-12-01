/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.double_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool isDouble(Json value, string key) {
  return (value.type == Json.Type.float_);
}

/// Check if the Json value is a double (floating-point number).
bool isDouble(Json value) {
  return (value.type == Json.Type.float_);
}

unittest {
  // Test with float value
  Json floatVal = Json(3.14);
  assert(floatVal.isDouble);

  // Test with integer value
  Json intVal = Json(42);
  assert(!intVal.isDouble);

  // Test with boolean value
  Json boolVal = Json(true);
  assert(!boolVal.isDouble);

  // Test with string value
  Json strVal = Json("test");
  assert(!strVal.isDouble);

  // Test with null value
  Json nullVal = Json.init;
  assert(!nullVal.isDouble);

  // Test with array value
  Json arrVal = Json.emptyArray;
  assert(!arrVal.isDouble);

  // Test with object value
  Json objVal = Json.emptyObject;
  assert(!objVal.isDouble);
}
// #endregion double
