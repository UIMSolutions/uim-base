/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.set;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/// Sets multiple keys to values from a map
Json setValues(Json json, Json[string] map) {
  foreach (kv; map.byKeyValue) {
    json.set(kv.key, kv.value);
  }
  return json;
}

/// Sets multiple keys to the same value
Json setValues(Json json, string[] keys, Json value) {
  keys.each!(key => json.set(key, value));
  return json;
}

/// Set path with value
Json setPath(T)(Json json, string[] path, T value) {
  return setValue(json, path, Json(value));
}

/// Set path with value
Json setPath(T : Json)(Json json, string[] path, T value) {
  if (path.length == 0) {
    return json;
  }

  // path.length > 0 
  if (path.length == 1) {
    return json.setValue(path[0], value);
  }

  // path.length > 1 
  auto key = path[0];
  if (key !in json) {
    json[key] = Json.emptyObject;
  }

  json[key] = json[key].setPath(path[1 .. $], value);
  return json;
}
/// 
unittest {
    // Test: setPath with empty path (should return unchanged)
    auto json1 = Json.emptyObject;
    auto result1 = json1.setPath([], Json("value"));
    assert(result1 == Json.emptyObject);

    // Test: setPath with single key
    auto json2 = Json.emptyObject;
    auto result2 = json2.setPath(["name"], Json("test"));
    assert(result2["name"] == Json("test"));

    // Test: setPath with two keys (nested)
    auto json3 = Json.emptyObject;
    auto result3 = json3.setPath(["user", "name"], Json("alice"));
    assert(result3["user"].isObject);
    assert(result3["user"]["name"] == Json("alice"));

    // Test: setPath with three keys (deeply nested)
    auto json4 = Json.emptyObject;
    auto result4 = json4.setPath(["a", "b", "c"], Json(123));
    assert(result4["a"].isObject);
    assert(result4["a"]["b"].isObject);
    assert(result4["a"]["b"]["c"] == Json(123));

    // Test: setPath overwrites existing value at path
    auto json5 = Json.emptyObject;
    json5.setPath(["x", "y"], Json("old"));
    auto result5 = json5.setPath(["x", "y"], Json("new"));
    assert(result5["x"]["y"] == Json("new"));

    // Test: setPath creates intermediate objects if missing
    auto json6 = Json.emptyObject;
    auto result6 = json6.setPath(["level1", "level2", "level3"], Json("deep"));
    assert(result6["level1"]["level2"]["level3"] == Json("deep"));

    // Test: setPath on existing nested object
    auto json7 = Json.emptyObject;
    json7["outer"] = Json.emptyObject;
    auto result7 = json7.setPath(["outer", "inner"], Json("inside"));
    assert(result7["outer"]["inner"] == Json("inside"));

    // Test: setPath with Json array value
    auto json8 = Json.emptyObject;
    auto arr = Json.emptyArray;
    arr ~= Json(1);
    arr ~= Json(2);
    auto result8 = json8.setPath(["array"], arr);
    assert(result8["array"].length == 2);
    assert(result8["array"][0] == Json(1));
    assert(result8["array"][1] == Json(2));

    // Test: setPath with null value
    auto json9 = Json.emptyObject;
    auto result9 = json9.setPath(["nullable"], Json(null));
    assert(result9["nullable"].type == Json.Type.null_);

    // Test: setPath does not modify non-object Json
    auto json10 = Json(42);
    auto result10 = json10.setPath(["key"], Json("value"));
    assert(result10 == Json(42));
}

/// Sets a single key to a value
Json setValue(T)(Json json, string key, T value) {
  return json.set(key, Json(value));
}
/// 
unittest {
  // Test with string value
  auto json1 = Json.emptyObject;
  auto result = json1.setValue("name", "test");
  assert(result["name"] == Json("test"));

  // Test with integer value
  auto json2 = Json.emptyObject;
  auto result = json2.setValue("age", 42);
  assert(result["age"] == Json(42));

  // Test with boolean value
  auto json3 = Json.emptyObject;
  auto result = json3.setValue("active", true);
  assert(result["active"] == Json(true));

  // Test with double value
  auto json4 = Json.emptyObject;
  auto result = json4.setValue("price", 99.99);
  assert(result["price"] == Json(99.99));

  // Test overwriting existing value
  auto json5 = Json.emptyObject;
  json5.setValue("key", "old");
  auto result = json5.setValue("key", "new");
  assert(result["key"] == Json("new"));

  // Test with non-empty Json object
  auto json6 = parseJsonString(`{"existing": "value"}`);
  auto result = json6.setValue("new", "data");
  assert(result["existing"] == Json("value"));
  assert(result["new"] == Json("data"));

  // Test with array value
  auto json7 = Json.emptyObject;
  auto result = json7.setValue("items", [1, 2, 3]);
  assert(result["items"].length == 3);
  assert(result["items"][0] == Json(1));

  // Test chaining multiple setValue calls
  auto json8 = Json.emptyObject;
  auto result = json8.setValue("a", 1).setValue("b", 2).setValue("c", 3);
  assert(result["a"] == Json(1));
  assert(result["b"] == Json(2));
  assert(result["c"] == Json(3));

  // Test with null value
  auto json9 = Json.emptyObject;
  auto result = json9.setValue("nullable", null);
  assert(result["nullable"].type == Json.Type.null_);

  // Test setValue doesn't modify non-object Json
  auto json10 = Json(42);
  auto result = json.setValue("key", "value");
  assert(result == Json(42));
}

/// Sets a single key to a value
Json setValue(T : Json)(Json json, string key, T value) {
  if (json.isObject) {
    json[key] = value;
  }
  return json;
}
///
unittest {
  // Test setting Json value on empty object
  auto json1 = Json.emptyObject;
  auto result1 = json1.setValue("key", Json("value"));
  assert(result1.isObject);
  assert(result1["key"] == Json("value"));

  // Test setting Json value on existing object
  auto json2 = Json.emptyObject;
  json2["existing"] = Json(42);
  auto result2 = json2.setValue("new", Json("data"));
  assert(result2["existing"] == Json(42));
  assert(result2["new"] == Json("data"));

  // Test overwriting existing Json value
  auto json3 = Json.emptyObject;
  json3["key"] = Json("old");
  auto result3 = json3.setValue("key", Json("new"));
  assert(result3["key"] == Json("new"));

  // Test with Json object value
  auto json4 = Json.emptyObject;
  auto nestedObj = Json.emptyObject;
  nestedObj["nested"] = Json("value");
  auto result4 = json4.setValue("object", nestedObj);
  assert(result4["object"]["nested"] == Json("value"));

  // Test with Json array value
  auto json5 = Json.emptyObject;
  auto arr = Json.emptyArray;
  arr ~= Json(1);
  arr ~= Json(2);
  auto result5 = json5.setValue("array", arr);
  assert(result5["array"].length == 2);
  assert(result5["array"][0] == Json(1));

  // Test with Json null value
  auto json6 = Json.emptyObject;
  auto result6 = json6.setValue("nullable", Json(null));
  assert(result6["nullable"].type == Json.Type.null_);

  // Test with Json boolean value
  auto json7 = Json.emptyObject;
  auto result7 = json7.setValue("flag", Json(true));
  assert(result7["flag"] == Json(true));

  // Test with Json number value
  auto json8 = Json.emptyObject;
  auto result8 = json8.setValue("number", Json(123.45));
  assert(result8["number"] == Json(123.45));

  // Test on non-object Json (should return unchanged)
  auto json9 = Json(42);
  auto result9 = json9.setValue("key", Json("value"));
  assert(result9 == Json(42));
  assert(result9.type == Json.Type.int_);

  // Test on Json array (should return unchanged)
  auto json10 = Json.emptyArray;
  auto result10 = json10.setValue("key", Json("value"));
  assert(result10.type == Json.Type.array);
  assert(result10.length == 0);

  // Test on Json null (should return unchanged)
  auto json11 = Json(null);
  auto result11 = json11.setValue("key", Json("value"));
  assert(result11.type == Json.Type.null_);

  // Test chaining multiple setValue calls
  auto json12 = Json.emptyObject;
  auto result12 = json12.setValue("a", Json(1))
    .setValue("b", Json(2))
    .setValue("c", Json(3));
  assert(result12["a"] == Json(1));
  assert(result12["b"] == Json(2));
  assert(result12["c"] == Json(3));

  // Test with empty string key
  auto json13 = Json.emptyObject;
  auto result13 = json13.setValue("", Json("empty_key"));
  assert(result13[""] == Json("empty_key"));

  // Test that original json is modified (by reference)
  auto json14 = Json.emptyObject;
  json14.setValue("test", Json("modified"));
  assert(json14["test"] == Json("modified"));
}

// #region Json[string]
/* Json[string] setNull(Json[string] map, string key) {
  return map.set(key, Json(null));
}

Json[string] set(T)(Json[string] map, string key, T value) {
  return map.set(key, value.toJson);
}

Json[string] set(T:string)(Json[string] map, string key, T value) {
  return map.set(key, value.toJson);
}

Json[string] set(T)(Json[string] map, string key, T[] value) {
  return map.set(key, value.toJson);
}

Json[string] set(T:string)(Json[string] map, string key, T[] value) {
  return map.set(key, value.toJson);
}

Json[string] set(T)(Json[string] map, string key, T[string] value) {
  return map.set(key, value.toJson);
}

Json[string] set(T:string)(Json[string] map, string key, T[string] value) {
  return map.set(key, value.toJson);
}

Json[string] set(T : Json)(Json[string] map, string key, T value) {
  map[key] = value;
  return map;
}

unittest {
  Json[string] map;
  assert(map.set("bool", true).getBoolean("bool"));
  assert(map.set("bool", true).getBoolean("bool"));
  assert(map.set("long", 1).getLong("long") == 1);
  assert(map.set("double", 0.1).getDouble("double") == 0.1);
  assert(map.set("string", "A").getString("string") == "A");
  assert(map.set("strings", ["x": "X", "y": "Y", "z": "Z"]) !is null);
}
 */
// #region Json[string]
Json[string] setValues(Json[string] map, Json[string] values) {
  values.byKeyValue.each!(kv => map = map.set(kv.key, kv.value));
  return map;
}

Json[string] setValues(Json[string] map, string[] keys, Json value) {
  keys.each!(key => map = map.set(key, value));
  return map;
}

Json[string] set(T)(Json[string] map, T[string] values) {
  values.each!((key, value) => map.set(key, value));
  return map;
}

Json[string] set(T)(Json[string] map, string[] keys, T value) {
  keys.each!(key => map.set(key, value));
  return map;
}

Json[string] setPath(T)(Json[string] map, string[] path, T value) {
  if (path.length == 0) {
    return map;
  }

  if (path.length == 1) {
    return map.set(path[0], value);
  }

  if (!map.hasKey(path[0])) {
    map[path[0]] = Json.emptyObject;
  }

  return map.set(map[path[0]], path[1 .. $], value);
}

Json[string] setObject(Json[string] map, string[] keys) {
  return map.set(keys, Json.emptyObject);
}

Json[string] setObject(Json[string] map, string key) {
  return map.set(key, Json.emptyObject);
}

Json[string] setArray(Json[string] map, string[] keys) {
  return map.set(keys, Json.emptyArray);
}

Json[string] setArray(Json[string] map, string key) {
  return map.set(key, Json.emptyArray);
}

Json[string] setNull(Json[string] map, string[] keys) {
  return map.set(keys, Json(null));
}

Json[string] setNull(Json[string] map, string key) {
  return map.set(key, Json(null));
}

Json[string] set(V : Json, T)(V[string] map, string key, T value) if (!is(V == T)) {
  return map.set(key, value.toJson);
}

Json[string] set(Json[string] map, string key, Json value) {
  if (map is null) {
    map = [key: value];
  } else {
    map[key] = value;
  }

  return map;
}

unittest {
  Json[string] json = ["a": Json("A")];
  assert(json["a"] == Json("A"));

  json.set("b", Json("B")).set("c", Json("C"));
  assert(json.hasAllKey(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.removeAll.set("a", "A");
  assert(json["a"] == Json("A"));

  json.set("b", "B").set("c", "C");
  assert(json.hasAllKey(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.removeAll.set("a", "A");
  assert(json["a"] == Json("A"));

  json.set(["b", "c"], "X");
  assert(json.hasAllKey(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));

  json = json.removeAll.set("a", "A");
  assert(json["a"] == Json("A"));

  json.set(["b": "B", "c": "C"]);
  assert(json.hasAllKey(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
// #endregion Json[string]

/** 
// #region Json
Json setNull(Json json, string key) {
  return json.set(key, Json(null));
}

Json set(T)(Json json, string key, T[] value) {
  return json.set(key, value.toJson);
}

Json set(T:string)(Json json, string key, T[] value) {
  return json.set(key, value.toJson);
}

Json set(T)(Json json, string key, T[string] value) {
  return json.set(key, value.toJson);
}

Json set(T:string)(Json json, string key, T[string] value) {
  return json.set(key, value.toJson);
}

Json set(T)(Json json, string key, T value) if (!is(T == Json)) {
  return json.set(key, value.toJson);
}

Json set(Json json, string key, strinh value) {
  return json.set(key, value.toJson);
}

Json set(Json json, string key, Json value) {
  if (json.isNull) {
    json = Json.emptyObject;
  }
  json[key] = value;
  return json;
}

unittest {
  Json json = Json.emptyObject;
  assert(json.set("bool", true).getBoolean("bool"));
  assert(json.set("bool", true).getBoolean("bool"));
  assert(json.set("long", 1).getLong("long") == 1);
  assert(json.set("double", 0.1).getDouble("double") == 0.1);
  assert(json.set("string", "A").getString("string") == "A");
  assert(json.set("strings", ["x": "X", "y": "Y", "z": "Z"]) != Json(null));
}
// #endregion Json
 */

// #region Json
auto set(T)(ref Json json, Json map) {
  if (json.isObject && map.isObject) {
    map.byKeyValue.each!(kv => json.set(kv.key, kv.value));
  }
  return json;
}

auto set(T)(ref Json json, T[string] values) {
  if (json.isObject) {
    values.each!((key, value) => json.set(key, value));
  }
  return json;
}

auto set(T)(ref Json json, string[] keys, T value) {
  keys.each!(key => json.set(key, value));
  return json;
}

auto ref set(T)(ref Json json, string key, T value) {
  return json.isObject
    ? json.set(key, value.toJson) : json;
}

auto ref setObject(ref Json json, string[] keys) {
  return json.set(keys, Json.emptyObject);
}

auto ref setObject(ref Json json, string key) {
  return json.set(key, Json.emptyObject);
}

auto ref setArray(ref Json json, string[] keys) {
  return json.set(keys, Json.emptyArray);
}

auto ref setArray(ref Json json, string key) {
  return json.set(key, Json.emptyArray);
}

auto ref setNull(ref Json json, string[] keys) {
  return json.set(keys, Json(null));
}

auto ref setNull(ref Json json, string key) {
  return json.set(key, Json(null));
}

auto ref set(ref Json json, string key, Json value) {
  if (json.isObject) {
    json[key] = value;
  }
  return json;
}
// #endregion Json

unittest {
  auto json = Json.emptyObject;
  json.set("a", "A");
  json.set("b", "B");
  json.set("c", "C");
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
  assert(json.hasAllKey(["a", "b", "c"]));

  json = Json.emptyObject;
  json.set("a", Json("A"));
  json.set("b", Json("B"));
  json.set("c", Json("C"));
  assert(json.hasAllKey(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json.set(["a", "b", "c"], "x");
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.set(["a", "b", "c"], Json("x"));
  assert(json.hasAllKey(["a", "b", "c"]));
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.set(["a": "A", "b": "B", "c": "C"]);
  assert(json.hasAllKey(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.set(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(json.hasAllKey(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
// #endregion Json

// #region set
// Returns a new map with updated values for existing keys
/* ref set(K : string, V:
  Json, T:
  Json)(ref V[K] json, T[K] others, K[] keys = null) if (is(typeof(T) == Json)) {
  keys.length == 0
    ? others
    .each!((key, value) => json.set(key, value)) : keys
    .filter!(key => key in others)
    .each!(key => json.set(key, others[key]));

  return json;
}
 */
/*   // Returns a new map with updated values for existing keys
  ref set(K : string, V:Json, T)(ref V[K] json, T[K] others, K[] keys = null) if (!is(typeof(T) == Json)) {
    keys.length == 0
      ? others
      .each!((key, value) => json.set(key, value)) : keys
      .filter!(key => key in others)
      .each!(key => json.set(key, others[key]));

    return json;
  }

  // returns a updated map with new values
  ref set(K : string, V:
    Json, T)(ref V[K] json, K[] keys, V value) {
    keys.each!(key => json.set(key, value));
    return json;
  } */
