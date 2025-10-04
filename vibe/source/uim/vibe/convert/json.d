/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.convert.json;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

// #region UUID
Json toJson(string key, UUID value) {
  auto json = Json.emptyObject;
  json[key] = value.toJson;
  return json;
}

Json toJson(T : UUID)(T value) {
  return Json(value.toString);
}

unittest { // Json toJson(UUID value)
  // Test that toJson(UUID) returns a Json with the correct string representation
  auto id = randomUUID;
  auto json = toJson(id);
  assert(json.type == Json.Type.string, "Expected Json string type");
  assert(json.get!string == id.toString, "UUID string mismatch in Json");
}

unittest { // Json toJson(string key, UUID value)
  // Test that toJson(string key, UUID value) returns a Json object with the correct key and UUID string
  auto id = randomUUID;
  string key = "uuid";
  auto json = toJson(key, id);
  assert(json.type == Json.Type.object, "Expected Json object type");
  assert(key in json, "Key should exist in Json object");
  assert(json[key].type == Json.Type.string, "Expected Json string type for value");
  assert(json[key].get!string == id.toString, "UUID string mismatch in Json object");
}
// #endregion UUID

// #region convert
T[] convert(T)(Json json, T delegate(string key, Json value) @safe func) {
  if (!json.isObject) {
    return null;
  }

  return json.byKeyValue.map!(kv => func(kv.key, kv.value)).array;
}

T[] convert(T)(Json json, T delegate(string key) @safe func) {
  if (!json.isObject) {
    return null;
  }

  return json.byKeyValue.map!(kv => func(kv.key)).array;
}

T[] convert(T)(Json json, T delegate(Json value) @safe func) {
  if (!json.isObject && !json.isArray) {
    return null;
  }

  return json.byValue.map!(value => func(value)).array;
}

unittest { // convert(Json, delegate(string, Json))
  // Prepare a Json object
  auto obj = Json.emptyObject;
  obj["a"] = 1;
  obj["b"] = 2;
  obj["c"] = 3;

  assert(obj.convert((string key, Json value) => key.length + value.get!int) == [4, 2, 3]);
  assert(obj.convert((string key) => key.length) == [1, 1, 1]);
  assert(obj.convert((Json value) => value.get!int) == [3, 1, 2]);

  auto list = Json.emptyArray;
  list ~= 1;
  list ~= 2;
  list ~= 3;
  assert(list.convert((Json value) => value.get!int) == [1, 2, 3]);
}
// #endregion convert
