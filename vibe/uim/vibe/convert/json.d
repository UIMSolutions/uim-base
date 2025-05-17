/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.convert.json;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region UUID
Json toJson(string key, UUID value) {
  auto json = Json.emptyObject;
  json[key] = value.toJson;
  return json;
}

Json toJson(T:UUID)(T value) {
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