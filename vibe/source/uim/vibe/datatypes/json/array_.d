/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.json.array_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

bool allArray(Json json) {
  if (json.isArray) {
    return json.toArray.allArray;
  }
  if (json.isMap) {
    return json.toMap.allArray;
  }
  return false;
}

bool allArray(Json[] values) {
  return values.all!(value => value.isArray);
}

bool allArray(Json[string] map) {
  return map.byValue.array.allArray;
}

bool anyArray(Json json) {
  if (json.isArray) {
    return json.toArray.anyArray;
  }
  if (json.isMap) {
    return json.toMap.anyArray;
  }
  return false;
}

/** 
  * Checks if any element in the array is of boolean type.
  *
  * Params:
  *   values = The array to check.
  *
  * Returns:
  *   `true` if any element is a boolean, `false` otherwise.
  *
  * Examples:
  * ```d
  * Json[] array1 = [Json(1), Json(2), Json(3)];
  * assert(!array1.anyArray); // false
  *
  * Json[] array2 = [Json(1), Json(true), Json(3)];
  * assert(array2.anyArray); // true
  *
  * Json[] arr3 = [Json("a"), Json("b"), Json(false)];
  * assert(arr3.anyArray); // true
  * ```
  */
bool anyArray(Json[] values) {
  return values.any!(json => json.isArray);
}

bool anyArray(Json[string] map) {
  return map.byValue.array.anyArray;
}

/**
  * Checks if the given JSON value is an array.
  *
  * Params:
  *   json = The JSON value to check.
  *
  * Returns:
  *   `true` if the JSON value is an array, `false` otherwise.
  *
  * Examples:
  * ```d
  * auto jsonArray = parseJsonString(`["a", "b", "c"]`);
  * assert(isArray(jsonArray)); // true
  *
  * auto jsonObject = parseJsonString(`{"a": "b"}`);
  * assert(!isArray(jsonObject)); // false
  * ```
  */
bool isArray(Json json) {
  return json == Json(null)
    ? false : json.type == Json.Type.array;
}
/// 
unittest {
  // Test: isArray returns true for a JSON array
  auto arr = parseJsonString(`["x", "y", "z"]`);
  assert(isArray(arr) == true);

  // Test: isArray returns false for a JSON object
  auto obj = parseJsonString(`{"key": "value"}`);
  assert(isArray(obj) == false);

  // Test: isArray returns false for JSON null
  auto nullJson = Json(null);
  assert(isArray(nullJson) == false);

  // Test: isArray returns false for a JSON string
  auto str = parseJsonString(`"hello"`);
  assert(isArray(str) == false);

  // Test: isArray returns false for a JSON number
  auto num = parseJsonString(`42`);
  assert(isArray(num) == false);

  // Test: isArray returns false for a JSON boolean
  auto boolean = parseJsonString(`true`);
  assert(isArray(boolean) == false);

  // Test: isArray returns false for an empty JSON array
  auto emptyArr = parseJsonString(`[]`);
  assert(isArray(emptyArr) == true);

  // Test: isArray returns false for an empty JSON object
  auto emptyObj = parseJsonString(`{}`);
  assert(isArray(emptyObj) == false);
}

// #region has Value
bool hasAllValues(T)(Json json, T[] values) {
  return values.all!(value => json.hasValue(value));
}

bool hasAnyValues(T)(Json json, T[] values) {
  return values.any!(value => json.hasValue(value));
}

bool hasValue(T)(Json json, T value) {
  return json.hasValue(value.toJson);
}

bool hasValue(T : Json)(Json json, T value) {
  return json.isArray || json.isObject
    ? json.byValue.any!(v => v == value) : json == value;
}

unittest {
  auto json = Json.emptyArray;
  json ~= Json(1);
  json ~= Json(2);
  json ~= Json(3);

  writeln(json.toString);
  assert(json.hasValue(Json(1)));
  assert(!json.hasValue(Json("1")));

  assert(json.hasValue(1));
  assert(!json.hasValue("1"));

  assert(json.hasAnyValues([Json(1), Json(2), Json(10)]));
  assert(!json.hasAnyValues([Json(10), Json(12), Json(13)]));

  assert(json.hasAnyValues([1, 2, 10]));
  assert(!json.hasAnyValues([10, 12, 13]));

  assert(json.hasAllValues([Json(1), Json(2), Json(3)]));
  assert(!json.hasAllValues([Json(1), Json(12), Json(13)]));

  assert(json.hasAllValues([1, 2, 3]));
  assert(!json.hasAllValues([1, 12, 13]));
}
// #endregion has

// #region get
mixin(GetJsonValue!("Json[]", "Array", "null"));

Json[] getArray(Json json) {
  return json.isArray
    ? json.get!(Json[]) : null;
}

unittest {
  auto a = Json.emptyArray;
  a ~= 1;
  a ~= 2;
  assert(a.length == 2);
  assert(a.getIntegerAt(0) == 1 && a.getIntegerAt(1) == 2);
  assert(a.getIntegerAt(0) != 2 && a.getIntegerAt(1) != 1);

  auto b = Json.emptyArray;
  b ~= 1;
  b ~= 2;
  b ~= 3;
  assert(b.length == 3);
  assert(b.getIntegerAt(0) == 1 && b.getIntegerAt(1) == 2);
  assert(b.getIntegerAt(2) == 3 && b.getIntegerAt(0) != 2);

  Json json = Json.emptyArray;
  json = [a, b];
  assert(json.length == 2);

  assert(json.getArrayAt(0).length == 2);
  assert(json.getArrayAt(1).length != 2);

  json = Json.emptyObject;
  json["One"] = a;
  json["Two"] = b;
  assert(json.getArray("One").length == 2);
  assert(json.getArray("Two").length != 2);

  auto list = [a, b];
  assert(list.getArrayAt(0).length == 2);
  assert(list.getArrayAt(1).length != 2);

  auto map = ["One": a, "Two": b];
  assert(map.getArray("One").length == 2);
  assert(map.getArray("Two").length != 2);
}
// #endregion get
