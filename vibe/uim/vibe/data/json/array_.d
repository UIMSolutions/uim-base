/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.array_;

import uim.data;

@safe:

// #region is
// #endregion is

// #region hasAll
bool hasAll(T)(Json json, T[] values...) {
  return json.hasAll(values.dup);
}

bool hasAll(T)(Json json, T[] values) {
  return json.hasAll(values.map!(value => value.toJson).array);
}

bool hasAll(Json json, Json[] values...) {
  return json.hasAll(values.dup);
}

bool hasAll(Json json, Json[] values) {
  if (!json.isArray)
    return false;

  return values.all!(value => json.has(value));
}
// #endregion hasAll

// #region hasAny
bool hasAny(T)(Json json, T[] values...) {
  return json.hasAny(values.dup);
}

bool hasAny(T)(Json json, T[] values) {
  return json.hasAny(values.map!(value => value.toJson).array);
}

bool hasAny(Json json, Json[] values...) {
  return json.hasAny(values.dup);
}

bool hasAny(Json json, Json[] values) {
  if (!json.isArray)
    return false;

  return values.any!(value => json.has(value));
}
// #endregion hasAny

// #region has
bool has(T)(Json json, T value) {
  return json.has(value.toJson);
}

bool has(Json json, Json value) {
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

  assert(json.hasAny(Json(1), Json(2), Json(10)));
  assert(!json.hasAny(Json(10), Json(12), Json(13)));

  assert(json.hasAny([1, 2, 10]));
  assert(!json.hasAny([10, 12, 13]));

  assert(json.hasAny(1, 2, 10));
  assert(!json.hasAny(10, 12, 13));

  assert(json.hasAll([Json(1), Json(2), Json(3)]));
  assert(!json.hasAll([Json(1), Json(12), Json(13)]));

  assert(json.hasAll(Json(1), Json(2), Json(3)));
  assert(!json.hasAll(Json(1), Json(12), Json(13)));

  assert(json.hasAll([1, 2, 3]));
  assert(!json.hasAll([1, 12, 13]));

  assert(json.hasAll(1, 2, 3));
  assert(!json.hasAll(1, 12, 13));
}
// #endregion has
