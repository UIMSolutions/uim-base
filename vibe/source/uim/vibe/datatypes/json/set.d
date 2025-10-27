/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.json.set;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:


Json setValues(Json json, Json[string] map) {
  foreach(kv; map.byKeyValue) {
    json.set(kv.key, kv.value);
  }
  return json;
}

Json setValues(Json json, string[] keys, Json value) {
  keys.each!(key => json.set(key, value));
  return json;
}

Json setPath(T)(Json json, string[] path, T value) {
  return setValue(json, path, Json(value));
}

Json setPath(T:Json)(Json json, string[] path, T value) {
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

  json[key] = json[key].setPath(path[1..$], value);
  return json;
}

Json setValue(T)(Json json, string key, T value) {
  return json.set(key, Json(value));
}

Json setValue(T:Json)(Json json, string key, T value) {
  if (json.isObject) {
    json[key] = value;
  }
  return json;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);

  json.set("a", Json("A"));
  assert(json["a"] == Json("A"));

  json.set(["a", "b"], Json("B"));
  assert(json["a"] == Json("B"));

  json.set(["c"], Json("C"));
  assert(json["c"] == Json("C"));
}
// #endregion set

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
  writeln("Json[string] set(Json[string] json, string key, Json value)");
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
  writeln("json: ", json.toString);
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

auto ref  setObject(ref Json json, string[] keys) {
  return json.set(keys, Json.emptyObject);
}

auto ref  setObject(ref Json json, string key) {
  return json.set(key, Json.emptyObject);
}

auto ref  setArray(ref Json json, string[] keys) {
  return json.set(keys, Json.emptyArray);
}

auto ref  setArray(ref Json json, string key) {
  return json.set(key, Json.emptyArray);
}

auto ref  setNull(ref Json json, string[] keys) {
  return json.set(keys, Json(null));
}

auto ref  setNull(ref Json json, string key) {
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

  writeln(json.toString);
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
