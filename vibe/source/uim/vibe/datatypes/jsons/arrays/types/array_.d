/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.array_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool allArray(Json json) {
  if (uim.vibe.datatypes.jsons.json.types.array_.isArray(json)) {
    return json.toArray.allArray;
  }
  if (json.isObject) {
    return json.toMap.allArray;
  }
  return false;
}

bool allArray(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.array_.isArray(value));
}

bool allArray(Json[string] map) {
  return map.byValue.array.allArray;
}

bool anyArray(Json json) {
  if (uim.vibe.datatypes.jsons.json.types.array_.isArray(json)) {
    return json.toArray.anyArray;
  }
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.maps.types.array_.anyArray(json.toMap);
  }
  return false;
}

bool isArray(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.array_.isArray(values[index]);
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
  return values.any!(json => uim.vibe.datatypes.jsons.json.types.array_.isArray(json));
}

bool hasValue(T : Json)(Json json, T value) {
  return uim.vibe.datatypes.jsons.json.types.array_.isArray(json) || json.isObject
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

  assert(json.hasAnyValue([Json(1), Json(2), Json(10)]));
  assert(!json.hasAnyValue([Json(10), Json(12), Json(13)]));

  assert(json.hasAnyValue([1, 2, 10]));
  assert(!json.hasAnyValue([10, 12, 13]));

  assert(json.hasAllValue([Json(1), Json(2), Json(3)]));
  assert(!json.hasAllValue([Json(1), Json(12), Json(13)]));

  assert(json.hasAllValue([1, 2, 3]));
  assert(!json.hasAllValue([1, 12, 13]));
}
// #endregion has

// #region get
Json[] getArray(Json json) {
  return uim.vibe.datatypes.jsons.json.types.array_.isArray(json)
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
