/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.set;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

/// Sets multiple keys to values from a map
Json setValues(Json json, Json[string] map) {
  auto result = json; 
  foreach (kv; map.byKeyValue) {
    result.set(kv.key, kv.value);
  }
  return result;
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


/// Sets a single key to a value
Json setValue(T : Json)(Json json, string key, T value) {
  if (json.isObject) {
    json[key] = value;
  }
  return json;
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
