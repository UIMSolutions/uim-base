/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.set;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region set
Json[string] setValues(Json[string] map, Json[string] values) {
  foreach(kv; values.byKeyValue) {
    map = map.setValue(kv.key, kv.value);
  }
  return map;
}

Json[string] setValues(Json[string] map, string[] keys, Json value) {
  keys.each!(key => map = map.setValue(key, value));
  return map;
}

Json[string] setValue(Json[string] map, string key, Json value) {
  map[key] = value;
  return map;
}

Json setValues(Json json, Json[string] map) {
  foreach(kv; map.byKeyValue) {
    json = json.setValue(kv.key, kv.value);
  }
  return json;
}

Json setValues(Json json, string[] keys, Json value) {
  keys.each!(key => json = json.setValue(key, value));
  return json;
}

Json setValue(T)(Json json, string[] path, T value) {
  return setValue(json, path, Json(value));
}

Json setValue(T:Json)(Json json, string[] path, T value) {
  if (path.length == 0) {
    return json;
  }

  if (path.length == 1) {
    return json.setValue(path[0], value);
  }

  auto key = path[0];
  if (key !in json) {
    json[key] = Json.emptyObject;
  }

  json[key] = json[key].setValue(path[1..$], value);
  return json;
}

Json setValue(T)(Json json, string key, T value) {
  return json.setValue(key, Json(value));
}

Json setValue(T:Json)(Json json, string key, T value) {
  if (json.isObject) {
    json[key] = value;
  }
  return json;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);

  json = json.setValue("a", Json("A"));
  assert(json["a"] == Json("A"));

  json = json.setValues(["a", "b"], Json("B"));
  assert(json["a"] == Json("B"));

  json = json.setValues(["c"], Json("C"));
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
Json[string] set(T)(Json[string] data, T[string] values) {
  auto results = data.dup;
  values.each!((key, value) => results = results.set(key, value));
  return results;
}

Json[string] set(T)(Json[string] data, string[] keys, T value) {
  auto results = data.dup;
  keys.each!(key => results = results.set(key, value));
  return results;
}

Json[string] setPath(T)(Json[string] data, string[] path, T value) {
  Json[string] result = data.dup;
  if (path.length == 0) {
    return result;
  }

  if (path.length == 1) {
    return set(result, path[0], value);
  }

  if (!result.hasKey(path[0])) {
    results[path[0]] = Json.emptyObject;
  }

  result[path[0]] = set(result[path[0]], path[1 .. $], value);

  return result;
}

Json[string] set(V : Json, T)(V[string] data, string key, T value) if (!is(V == T)) {
  return set(data, key, value.toJson);
}

Json[string] setObject(Json[string] data, string[] keys) {
  return data.set(keys, Json.emptyObject);
}

Json[string] setObject(Json[string] data, string key) {
  return data.set(key, Json.emptyObject);
}

Json[string] setArray(Json[string] data, string[] keys) {
  return data.set(keys, Json.emptyArray);
}

Json[string] setArray(Json[string] data, string key) {
  return data.set(key, Json.emptyArray);
}

Json[string] setNull(Json[string] data, string[] keys) {
  return data.set(keys, Json(null));
}

Json[string] setNull(Json[string] data, string key) {
  return data.set(key, Json(null));
}

Json[string] set(Json[string] data, string key, Json value) {
  writeln("Json[string] set(Json[string] data, string key, Json value)");
  if (data is null) {
    data = [key: value];
  } else {
    data[key] = value;
  }

  return data;
}

unittest {
  Json[string] data = null;
  data = data.set("a", Json("A"));
  assert(data["a"] == Json("A"));

  data.set("b", Json("B")).set("c", Json("C"));
  assert(data.hasAllKeys(["a", "b", "c"]));
  assert(data["a"] == Json("A") && data["b"] == Json("B") && data["c"] == Json("C"));

  data = data.removeAll.set("a", "A");
  assert(data["a"] == Json("A"));

  data.set("b", "B").set("c", "C");
  assert(data.hasAllKeys(["a", "b", "c"]));
  assert(data["a"] == Json("A") && data["b"] == Json("B") && data["c"] == Json("C"));

  data = data.removeAll.set("a", "A");
  assert(data["a"] == Json("A"));

  data = data.set(["b", "c"], "X");
  assert(data.hasAllKeys(["a", "b", "c"]));
  assert(data["a"] == Json("A") && data["b"] == Json("X") && data["c"] == Json("X"));

  data = data.removeAll.set("a", "A");
  assert(data["a"] == Json("A"));
  
  data = data.set(["b": "B", "c": "C"]);
  assert(data.hasAllKeys(["a", "b", "c"]));
  assert(data["a"] == Json("A") && data["b"] == Json("B") && data["c"] == Json("C"));
}
// #endregion Json[string]

/** 
// #region Json
Json setNull(Json data, string key) {
  return data.set(key, Json(null));
}

Json set(T)(Json data, string key, T[] value) {
  return data.set(key, value.toJson);
}

Json set(T:string)(Json data, string key, T[] value) {
  return data.set(key, value.toJson);
}

Json set(T)(Json data, string key, T[string] value) {
  return data.set(key, value.toJson);
}

Json set(T:string)(Json data, string key, T[string] value) {
  return data.set(key, value.toJson);
}

Json set(T)(Json data, string key, T value) if (!is(T == Json)) {
  return data.set(key, value.toJson);
}

Json set(Json data, string key, strinh value) {
  return data.set(key, value.toJson);
}

Json set(Json data, string key, Json value) {
  if (data.isNull) {
    data = Json.emptyObject;
  }
  data[key] = value;
  return data;
}

unittest {
  Json data = Json.emptyObject;
  assert(data.set("bool", true).getBoolean("bool"));
  assert(data.set("bool", true).getBoolean("bool"));
  assert(data.set("long", 1).getLong("long") == 1);
  assert(data.set("double", 0.1).getDouble("double") == 0.1);
  assert(data.set("string", "A").getString("string") == "A");
  assert(data.set("strings", ["x": "X", "y": "Y", "z": "Z"]) != Json(null));
}
// #endregion Json
 */

// #region Json
Json set(T)(Json data, Json map) {
  if (data.isObject && map.isObject) {
    map.byKeyValue.each!(kv => data = data.set(kv.key, kv.value));
  }
  return data;
}

Json set(T)(Json data, T[string] values) {
  if (data.isObject) {
    values.each!((key, value) => data = data.set(key, value));
  }
  return data;
}

Json set(T)(Json data, string[] keys, T value) {
  keys.each!(key => data = data.set(key, value));
  return data;
}

Json set(T)(Json data, string key, T value) {
  return data.isObject
    ? set(data, key, value.toJson) : data;
}

Json setObject(Json data, string[] keys) {
  return data.set(keys, Json.emptyObject);
}

Json setObject(Json data, string key) {
  return data.set(key, Json.emptyObject);
}

Json setArray(Json data, string[] keys) {
  return data.set(keys, Json.emptyArray);
}

Json setArray(Json data, string key) {
  return data.set(key, Json.emptyArray);
}

Json setNull(Json data, string[] keys) {
  return data.set(keys, Json(null));
}

Json setNull(Json data, string key) {
  return data.set(key, Json(null));
}

Json set(Json data, string key, Json value) {
  if (data.isObject) {
    data[key] = value;
  }
  return data;
}
// #endregion Json

unittest {
  auto data = Json.emptyObject;
  data = data.set("a", "A").set("b", "B").set("c", "C");
  assert(data["a"] == Json("A") && data["b"] == Json("B") && data["c"] == Json("C"));

  writeln(data.toString);
  assert(data.hasAllKeys(["a", "b", "c"]));

  data = Json.emptyObject;
  data = data.set("a", Json("A")).set("b", Json("B")).set("c", Json("C"));
  assert(data.hasAllKeys(["a", "b", "c"]));
  assert(data["a"] == Json("A") && data["b"] == Json("B") && data["c"] == Json("C"));

  data = data.set(["a", "b", "c"], "x");
  assert(data["a"] == Json("x") && data["b"] == Json("x") && data["c"] == Json("x"));

  data = Json.emptyObject;
  data = data.set(["a", "b", "c"], Json("x"));
  assert(data.hasAllKeys(["a", "b", "c"]));
  assert(data["a"] == Json("x") && data["b"] == Json("x") && data["c"] == Json("x"));

  data = Json.emptyObject;
  data = data.set(["a": "A", "b": "B", "c": "C"]);
  assert(data.hasAllKeys(["a", "b", "c"]));
  assert(data["a"] == Json("A") && data["b"] == Json("B") && data["c"] == Json("C"));

  data = Json.emptyObject;
  data = data.set(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(data.hasAllKeys(["a", "b", "c"]));
  assert(data["a"] == Json("A") && data["b"] == Json("B") && data["c"] == Json("C"));
}
// #endregion Json

// #region set
// Returns a new map with updated values for existing keys
/* ref set(K : string, V:
  Json, T:
  Json)(ref V[K] data, T[K] others, K[] keys = null) if (is(typeof(T) == Json)) {
  keys.length == 0
    ? others
    .each!((key, value) => data.set(key, value)) : keys
    .filter!(key => key in others)
    .each!(key => data.set(key, others[key]));

  return data;
}
 */
/*   // Returns a new map with updated values for existing keys
  ref set(K : string, V:Json, T)(ref V[K] data, T[K] others, K[] keys = null) if (!is(typeof(T) == Json)) {
    keys.length == 0
      ? others
      .each!((key, value) => data.set(key, value)) : keys
      .filter!(key => key in others)
      .each!(key => data.set(key, others[key]));

    return data;
  }

  // returns a updated map with new values
  ref set(K : string, V:
    Json, T)(ref V[K] data, K[] keys, V value) {
    keys.each!(key => data.set(key, value));
    return data;
  } */
