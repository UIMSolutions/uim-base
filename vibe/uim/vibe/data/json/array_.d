/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.array_;

import uim.vibe;

@safe:

// #region is
mixin(CheckJsonIs!("Array"));

Json[] isArray(Json json, Json[] strict = true) {
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

// #region hasAll
Json[] hasAll(T)(Json json, T[] values) {
  return json.hasAll(values.map!(value => value.toJson).array);
}

Json[] hasAll(Json json, Json[] values) {
  if (!json.isArray)
    return false;

  return values.all!(value => json.has(value));
}
// #endregion hasAll

// #region hasAny
Json[] hasAny(T)(Json json, T[] values) {
  return json.hasAny(values.map!(value => value.toJson).array);
}

Json[] hasAny(Json json, Json[] values) {
  if (!json.isArray)
    return false;

  return values.any!(value => json.has(value));
}
// #endregion hasAny

// #region has
Json[] has(T)(Json json, T value) {
  return json.has(value.toJson);
}

Json[] has(Json json, Json value) {
  if (!json.isArray)
    return false;

  return json.byValue.any!(v => v == value);
}

unittest {
  auto json = Json.emptyArray;
  json ~= Json(1);
  json ~= Json(2);
  json ~= Json(3);

  writeln(json.toString);
  assert(json.has(Json(1)));
  assert(!json.has(Json("1")));

  assert(json.has(1));
  assert(!json.has("1"));

  assert(json.hasAny([Json(1), Json(2), Json(10)]));
  assert(!json.hasAny([Json(10), Json(12), Json(13)]));

  assert(json.hasAny([1, 2, 10]));
  assert(!json.hasAny([10, 12, 13]));

  assert(json.hasAll([Json(1), Json(2), Json(3)]));
  assert(!json.hasAll([Json(1), Json(12), Json(13)]));

  assert(json.hasAll([1, 2, 3]));
  assert(!json.hasAll([1, 12, 13]));
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
  json ~= true;
  json ~= false;
  assert(json.getArray(0) == true);
  assert(json.getArray(1) != true);

  json = Json.emptyObject;
  json["One"] = true;
  json["Two"] = false;
  assert(json.getArray("One") == true);
  assert(json.getArray("Two") != true);

  auto list = [Json(true), Json(false)];
  assert(list.getArray(0) == true);
  assert(list.getArray(1) != true);

  auto map = ["One": Json(true), "Two": Json(false)];
  assert(map.getArray("One") == true);  
  assert(map.getArray("Two") != true);  
}
// #endregion get