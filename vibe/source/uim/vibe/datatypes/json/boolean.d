/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.boolean;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

/**
  * Checks if all specified elements in the array are of boolean type.
  *
  * Params:
  *   values = The array to check.
  *   indices = Optional indices to check within the array. If not provided, all elements are checked.
  *
  * Returns:
  *   `true` if all specified elements are booleans, `false` otherwise.
  *
  * Examples:
  * ```d
  * Json[] arr1 = [Json(true), Json(false), Json(1)];
  * assert(!arr1.isAllBoolean); // false
  *
  * Json[] arr2 = [Json(true), Json(false)];
  * assert(arr2.isAllBoolean); // true
  *
  * Json[] arr3 = [Json(true), Json(false), Json(1)];
  * assert(arr3.isAllBoolean([0, 1])); // true
  * assert(!arr3.isAllBoolean([0, 2])); // false
  * ```
  */
bool isAllBoolean(Json[] values) {
  return values.all!(json => json.isBoolean);
}
/// 
unittest {
    // Test with all booleans
    Json[] arr1 = [Json(true), Json(false)];
    assert(isAllBoolean(arr1), "Should be true: all elements are booleans");

    // Test with mixed types
    Json[] arr2 = [Json(true), Json(1), Json(false)];
    assert(!isAllBoolean(arr2), "Should be false: not all elements are booleans");

    // Test with empty array
    Json[] arr3 = [];
    assert(isAllBoolean(arr3), "Should be true: empty array (vacuously true)");

    // Test with single boolean
    Json[] arr4 = [Json(true)];
    assert(isAllBoolean(arr4), "Should be true: single boolean");

    // Test with single non-boolean
    Json[] arr5 = [Json("string")];
    assert(!isAllBoolean(arr5), "Should be false: single non-boolean");
}

/** 
  * Checks if all specified elements in the array are of boolean type.
  *
  * Params:
  *   values = The array to check.
  *   indices = Optional indices to check within the array. If not provided, all elements are checked.
  *
  * Returns:
  *   `true` if all specified elements are booleans, `false` otherwise.
  *
  * Examples:
  * ```d
  * Json[] arr1 = [Json(true), Json(false), Json(1)];
  * assert(!arr1.isAllBoolean); // false
  *
  * Json[] arr2 = [Json(true), Json(false)];
  * assert(arr2.isAllBoolean); // true
  *
  * Json[] arr3 = [Json(true), Json(false), Json(1)];
  * assert(arr3.isAllBoolean([0, 1])); // true
  * assert(!arr3.isAllBoolean([0, 2])); // false
  * ```
  */
bool isAllBoolean(Json[] values, size_t[] indices) {
  return indices.all!(i => i < values.length && values[i].isBoolean);
}
/// 
unittest {
    // Test with all booleans at specified indices
    Json[] arr = [Json(true), Json(false), Json(1)];
    size_t[] indices1 = [0, 1];
    assert(isAllBoolean(arr, indices1), "Should be true: indices 0 and 1 are booleans");

    // Test with mixed types at specified indices
    size_t[] indices2 = [0, 2];
    assert(!isAllBoolean(arr, indices2), "Should be false: index 2 is not a boolean");

    // Test with out-of-bounds index
    size_t[] indices3 = [0, 3];
    assert(!isAllBoolean(arr, indices3), "Should be false: index 3 is out of bounds");

    // Test with empty indices array
    size_t[] indices4 = [];
    assert(isAllBoolean(arr, indices4), "Should be true: empty indices (vacuously true)");

    // Test with single boolean index
    size_t[] indices5 = [1];
    assert(isAllBoolean(arr, indices5), "Should be true: index 1 is a boolean");

    // Test with single non-boolean index
    size_t[] indices6 = [2];
    assert(!isAllBoolean(arr, indices6), "Should be false: index 2 is not a boolean");
}

bool isAnyBoolean(Json[] values) {
  return values.any!(json => json.isBoolean);
}

bool isAnyBoolean(Json json) {
  return json.isArray
    ? json.toArray.isAnyBoolean
    : json.toMap.isAnyBoolean;
}

bool isBoolean(Json json) {
  return (json.type == Json.Type.bool_);
}

unittest { 
  // Json
  // strict
  assert(Json(true).isBoolean);
  assert(!Json("text").isBoolean);
  assert(!Json(10).isBoolean);
  assert(!Json(1.1).isBoolean);

  // not strict
  assert(Json(true).isBoolean(false));
  assert(Json("false").isBoolean(false));
  assert(Json("true").isBoolean(false));
  assert(Json("no").isBoolean(false));
  assert(Json("yes").isBoolean(false));
  assert(Json("0").isBoolean(false));
  assert(Json("1").isBoolean(false));
  assert(Json(0).isBoolean(false));
  assert(Json(1).isBoolean(false));
  assert(Json(0.0).isBoolean(false));
  assert(Json(true).isBoolean(false));

  Json map = Json.emptyObject;
  map["one"] = Json(1);  
  map["alfa"] = Json("text");
  map["t"] = Json(true);  
  map["f"] = Json(false);
  assert(!map.isBoolean);  
  assert(!map.isBoolean("one"));  
  assert(!map.isBoolean("alfa"));  
  assert(map.isBoolean("t"));  
  assert(map.isBoolean("f"));  

  map = Json.emptyObject;
  map["t"] = Json(true);  
  map["f"] = Json(false);
  assert(map.isAllBoolean);

  // Json[]
  auto a = Json(true);
  auto b = Json(false);
  auto c = Json(1);
  auto d = Json(1.1);
  auto list = [a, b, c, d];
  assert([a, b].isAllBoolean);
  assert(![a, c].isAllBoolean);

  assert(list.isAllBoolean([0, 1]));
  assert(!list.isAllBoolean([2, 3]));

  assert([a, b].isAnyBoolean);
  assert([a, c].isAnyBoolean);
  assert(![c, d].isAnyBoolean);

  assert(list.isAnyBoolean([0, 1]));
  assert(list.isAnyBoolean([1, 2]));
  assert(!list.isAnyBoolean([2, 3]));

  // Json[string]
  a = Json(true);
  b = Json(false);
  c = Json(1);
  d = Json(1.1);

  auto map2 = ["A": a, "B": b, "C": c, "D": d];
  assert(["A": a, "B": b].isAllBoolean);
  assert(!["A": a, "C": c].isAllBoolean);

  assert(map2.isAllBoolean(["A", "B"]));
  assert(!map2.isAllBoolean(["A", "C"]));

  assert(["A": a, "B": b].isAnyBoolean);
  assert(["A": a, "C": c].isAnyBoolean);
  assert(!["C": c, "D": d].isAnyBoolean);

  assert(map2.isAnyBoolean(["A", "B"]));
  assert(map2.isAnyBoolean(["A", "C"]));
  assert(!map2.isAnyBoolean(["C", "D"]));
}
// #endregion is

// #region get
mixin(GetJsonValue!("bool", "Boolean", "false"));

bool getBoolean(Json json) {
  return json.isBoolean
    ? json.get!bool : false;
}

unittest {
  Json json = Json(true);
  assert(json.getBoolean);

  json = Json.emptyArray;
  json ~= true;
  json ~= false;
  assert(json.getBooleanAt(0) == true);
  assert(json.getBooleanAt(1) != true);

  json = Json.emptyObject;
  json["One"] = true;
  json["Two"] = false;
  assert(json.getBoolean("One") == true);
  assert(json.getBoolean("Two") != true);

  auto list = [Json(true), Json(false)];
  assert(list.getBooleanAt(0) == true);
  assert(list.getBooleanAt(1) != true);

  auto map = ["One": Json(true), "Two": Json(false)];
  assert(map.getBoolean("One") == true);  
  assert(map.getBoolean("Two") != true);  
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
