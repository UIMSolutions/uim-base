/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.array_;

import uim.vibe;

@safe:

// #region is
mixin(IsJsonFunctions!("Array"));

bool isArray(Json json, bool strict = true) {
  if (json == Json(null)) {
    return false;
  }

  if (!strict) {
    // TODO: Future: Add support for array Json[]ean, integer, float, and string.
  }
  return json != Json(null)
    ? (json.type == Json.Type.array) : false;
}

unittest {
  assert(parseJsonString(`["a", "b", "c"]`).isArray);
  assert(!parseJsonString(`{"a": "b"}`).isArray);

  Json json = Json.emptyArray;
  json ~= Json("A");
  json ~= Json(1);
  assert(json.isArray);
}
// #endregion is

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

bool hasValue(T:Json)(Json json, T value) {
  return json.isArray || json.isObject
    ? json.byValue.any!(v => v == value)
    : json == value;
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

Json[] getArray(Json json, Json[] defaultValue = null) {
  return json.isArray
    ? json.get!(Json[]) : defaultValue;
}

unittest {
  Json json = Json(true);
  assert(json.getArray);

  json = Json.emptyArray;
  auto a = Json.emptyArray;
  a ~= 1; a ~= 2;
  auto b = Json.emptyArray;
  b ~= 1; b ~= 2; b ~= 3;
  
  json ~= a;
  json ~= b;
  assert(json.getArray(0).length == 2);
  assert(json.getArray(1).length != 2);

  json = Json.emptyObject;
  json["One"] = a;
  json["Two"] = b;
  assert(json.getArray("One").length == 2);
  assert(json.getArray("Two").length != 2);

  auto list = [a, b];
  assert(list.getArray(0).length == 2);
  assert(list.getArray(1).length != 2);

  auto map = ["One": a, "Two": b];
  assert(map.getArray("One").length == 2);
  assert(map.getArray("Two").length != 2);
}
// #endregion get