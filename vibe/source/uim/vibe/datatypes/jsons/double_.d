/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.json.double_;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

// #region is
mixin(IsJsonFunctions!("Double"));

/// Check if the Json value is a double (floating-point number).
bool isDouble(Json value, bool strict = true) {
  if (!strict) {
    // check for boolean, integer, and string types
  }
  return (value.type == Json.Type.float_);
}

unittest {
  // Test with float value
  Json floatVal = Json(3.14);
  assert(isDouble(floatVal));
  assert(floatVal.isDouble);

  // Test with integer value
  Json intVal = Json(42);
  assert(!isDouble(intVal));
  assert(!intVal.isDouble);

  // Test with boolean value
  Json boolVal = Json(true);
  assert(!isDouble(boolVal));
  assert(!boolVal.isDouble);

  // Test with string value
  Json strVal = Json("test");
  assert(!isDouble(strVal));
  assert(!strVal.isDouble);

  // Test with null value
  Json nullVal = Json.init;
  assert(!isDouble(nullVal));
  assert(!nullVal.isDouble);

  // Test with array value
  Json arrVal = Json.emptyArray;
  assert(!isDouble(arrVal));
  assert(!arrVal.isDouble);

  // Test with object value
  Json objVal = Json.emptyObject;
  assert(!isDouble(objVal));
  assert(!objVal.isDouble);

  // Test with strict = false (should still only return true for float)
  assert(isDouble(floatVal, false));
  assert(!isDouble(intVal, false));
  assert(!isDouble(boolVal, false));
  assert(!isDouble(strVal, false));
}

unittest { // Json[]
  auto a = Json(1.1);
  auto b = Json(2.1);
  auto c = Json(1);
  auto d = Json("1.1");
  auto list = [a, b, c, d];
  assert([a, b].isAllDouble);
  assert(![a, c].isAllDouble);

  assert(list.isAllDouble([0, 1]));
  assert(!list.isAllDouble([2, 3]));

  assert([a, b].isAnyDouble);
  assert([a, c].isAnyDouble);
  assert(![c, d].isAnyDouble);

  assert(list.isAnyDouble([0, 1]));
  assert(list.isAnyDouble([1, 2]));
  assert(!list.isAnyDouble([2, 3]));
}

unittest { // Json[string]
  auto a = Json(1.1);
  auto b = Json(2.1);
  auto c = Json(1);
  auto d = Json("1.1");
  auto map = ["A": a, "B": b, "C": c, "D": d];
  assert(["A": a, "B": b].isAllDouble);
  assert(!["A": a, "C": c].isAllDouble);

  assert(map.isAllDouble(["A", "B"]));
  assert(!map.isAllDouble(["A", "C"]));

  assert(["A": a, "B": b].isAnyDouble);
  assert(["A": a, "C": c].isAnyDouble);
  assert(!["C": c, "D": d].isAnyDouble);

  assert(map.isAnyDouble(["A", "B"]));
  assert(map.isAnyDouble(["A", "C"]));
  assert(!map.isAnyDouble(["C", "D"]));
}
// #endregion is

// #region get
mixin(GetJsonValue!("double", "Double", "0.0"));

/// Get the double value from the Json object associated with the specified key.
double getDouble(Json json) {
  return json.isDouble
    ? json.get!double : 0.0;
}

unittest {
  Json json = Json(1.0);
  assert(json.getDouble == 1.0);

  json = Json.emptyArray;
  json ~= 1.0;
  json ~= 2.0;
  assert(json.getDoubleAt(0) == 1.0);
  assert(json.getDoubleAt(1) != 1.0);

  json = Json.emptyObject;
  json["One"] = 1.0;
  json["Two"] = 2.0;
  assert(json.getDouble("One") == 1.0);
  assert(json.getDouble("Two") != 1.0);

  auto list = [Json(1.0), Json(2.0)];
  assert(list.getDoubleAt(0) == 1.0);
  assert(list.getDoubleAt(1) != 1.0);

  auto map = ["One": Json(1.0), "Two": Json(2.0)];
  assert(map.getDouble("One") == 1.0);
  assert(map.getDouble("Two") != 1.0);
}
// #endregion get

// #region only
// #endregion only

// #region set  
// #endregion set

// #region remove
// #endregion remove

// #region clear
// #endregion clear

// #region to
// #endregion to
