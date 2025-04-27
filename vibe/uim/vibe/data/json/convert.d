/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.convert;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region toJson
// #region value to Json
Json toJson(T)(T value) if (isScalarType!(T)) {
  return Json(value);
}
Json toJson(T:string)(T value) {
  return Json(value);
}
Json toJson(T:UUID)(T value) {
  return Json(value.toString);
}
Json toJson(T:Json)(T value) {
  return value;
}
unittest {
  assert(true.toJson == Json(true));
  assert(true.toJson.toJson == Json(true));

  assert(false.toJson != Json(true));
  assert(false.toJson.toJson != Json(true));

  assert(1.toJson == Json(1));
  assert(1.toJson.toJson == Json(1));

  assert((1.1).toJson == Json(1.1));
  assert((1.1).toJson.toJson == Json(1.1));

  assert("a".toJson == Json("a"));
  assert("a".toJson.toJson == Json("a"));

  auto id = randomUUID;
  assert(id.toJson == Json(id.toString));
}
// #endregion value to Json

// #region array to Json
Json toJson(T)(T[] values) {
  Json json = Json.emptyArray;
  values.each!(value => json ~= value.toJson);
  return json;
}
Json toJson(T:UUID)(UUID[] uuids) {
  Json result = Json.emptyArray;
  uuids.each!(uuid => result ~= uuid.toJson);
  return result;
}
unittest {
  assert([true, true, false].toJson.length == 3);
  assert([true, true, false].toJson[0].getBoolean);

  auto id = randomUUID;
  auto id2 = randomUUID;
  auto id3 = randomUUID;
  auto id4 = randomUUID;
  assert([id, id2, id3, id4].toJson.length == 4);
  assert([id, id2, id3, id4].toJson[0] == id.toJson);
}
// #endregion array to Json

// #region map to Json
Json toJson(T)(T[string] map) {
  Json json = Json.emptyObject;
  map.each!((key, value) => json[key] = value.toJson);
  return json;
}
unittest {
  string[string] map = ["A": "a", "B": "b"];
  assert(map.toJson["A"] == Json("a"));
}
// #endregion

// #region to Json object
// #region UUID 
Json toJson(string aKey, UUID uuid) {
  Json result = Json.emptyObject;
  result[aKey] = uuid.toJson;
  return result;
}
unittest {
  auto id = randomUUID;
  auto id2 = randomUUID;
  auto id3 = randomUUID;
  auto id4 = randomUUID;
  
  assert(id.toJson.get!string == id.toString);
  /* assert([id, id2, id3].toJson.has(id));
  assert(![id, id2, id3].toJson.has(id4)); */

  // assert([id, id2, id3].toJson.hasAll(id, id2, id3));
  // assert(id.toJson.get!string == id.toString);

  // assert(UUID(toJson("id", id)["id"].get!string) == id); */
}
// #endregion UUID

/// Special case for managing entities

Json toJson(UUID id, size_t versionNumber) {
  Json result = toJson("id", id);
  result["versionNumber"] = versionNumber;
  return result;
}

unittest {
  auto id = randomUUID;
  assert(toJson(id, 0).getString("id") == id.toString);
  assert("versionNumber" in toJson(id, 0));
  assert(toJson(id, 1)["id"].get!string == id.toString);
  assert(toJson(id, 1)["versionNumber"].get!size_t == 1);
}
// #endregion




Json toJson(string[] values) {
  auto json = Json.emptyArray;
  values.each!(value => json ~= value);
  return json;
}

unittest {
  assert(["a", "b", "c"].toJson.length == 3);
  assert(["a", "b", "c"].toJson[0] == "a");
}

Json toJson(string[string] map, string[] excludeKeys = null) {
  Json json = Json.emptyObject;
  map.byKeyValue
    .filter!(kv => !excludeKeys.any!(key => key == kv.key))
    .each!(kv => json[kv.key] = kv.value);
  return json;
}

unittest {
  assert(["a": "1", "b": "2", "c": "3"].toJson.length == 3);
  assert(["a": "1", "b": "2", "c": "3"].toJson["a"] == "1");
}

Json toJson(Json[string] map) {
  Json json = Json.emptyObject;  
  map.each!((key, value) => json[key] = value);
  return json;
}
// #endregion toJson

// #region toJsonMap
Json[string] toJsonMap(bool[string] values, string[] excludeKeys = null) {
  Json[string] result;
  values.byKeyValue
    .filter!(kv => !excludeKeys.any!(key => key in values))
    .each!(kv => result[kv.key] = Json(kv.value));
  return result;
}

Json[string] toJsonMap(long[string] values, string[] excludeKeys = null) {
  Json[string] result;
  values.byKeyValue
    .filter!(kv => !excludeKeys.any!(key => key in values))
    .each!(kv => result[kv.key] = Json(kv.value));
  return result;
}

Json[string] toJsonMap(double[string] values, string[] excludeKeys = null) {
  Json[string] result;
  values.byKeyValue
    .filter!(kv => !excludeKeys.any!(key => key in values))
    .each!(kv => result[kv.key] = Json(kv.value));
  return result;
}

Json[string] toJsonMap(string[string] items, string[] excludeKeys = null) {
  Json[string] result;
  items.byKeyValue
    .filter!(item => !excludeKeys.hasValue(item.key))
    .each!(item => result[item.key] = Json(item.value));
  return result;
}

unittest {
  // assert(["a": "A", "b": "B"].toJsonMap.length == 2);
  // assert(["a": "A", "b": "B"].toJsonMap.getString("a") == "A");
  // assert(["a": "A", "b": "B"].toJsonMap(["b"]).length == 1);
  // assert(["a": "A", "b": "B"].toJsonMap(["b"]).getString("a") == "A");
}
// #endregion toJsonMap