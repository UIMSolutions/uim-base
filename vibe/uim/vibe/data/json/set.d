/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.set;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

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
Json[string] set(T)(Json[string] items, T[string] values) {
  auto results = items.dup;
  values.each!((key, value) => results = results.set(key, value));
  return results;
}

Json[string] set(T)(Json[string] items, string[] keys, T value) {
  auto results = items.dup;
  keys.each!(key => results = results.set(key, value));
  return results;
}

Json[string] setPath(T)(Json[string] items, string[] path, T value) {
  Json[string] result = items.dup;
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

Json[string] set(V : Json, T)(V[string] items, string key, T value) if (!is(V == T)) {
  return set(items, key, value.toJson);
}

Json[string] set(Json[string] items, string key, Json value) {
  writeln("Json[string] set(Json[string] items, string key, Json value)");
  if (items is null) {
    items = [key: value];
  } else {
    items[key] = value;
  }

  return items;
}

unittest {
  Json[string] items = null;
  items = items.set("a", Json("A"));
  assert(items["a"] == Json("A"));

  items.set("b", Json("B")).set("c", Json("C"));
  assert(items.hasAllKeys(["a", "b", "c"]));
  assert(items["a"] == Json("A") && items["b"] == Json("B") && items["c"] == Json("C"));

  items = items.removeAll.set("a", "A");
  assert(items["a"] == Json("A"));

  items.set("b", "B").set("c", "C");
  assert(items.hasAllKeys(["a", "b", "c"]));
  assert(items["a"] == Json("A") && items["b"] == Json("B") && items["c"] == Json("C"));

  items = items.removeAll.set("a", "A");
  assert(items["a"] == Json("A"));

  items = items.set(["b", "c"], "X");
  assert(items.hasAllKeys(["a", "b", "c"]));
  assert(items["a"] == Json("A") && items["b"] == Json("X") && items["c"] == Json("X"));

  items = items.removeAll.set("a", "A");
  assert(items["a"] == Json("A"));
  
  items = items.set(["b": "B", "c": "C"]);
  assert(items.hasAllKeys(["a", "b", "c"]));
  assert(items["a"] == Json("A") && items["b"] == Json("B") && items["c"] == Json("C"));
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
Json set(T)(Json json, Json map) {
  if (json.isObject && map.isObject) {
    map.byKeyValue.each!(kv => json = json.set(kv.key, kv.value));
  }
  return json;
}

Json set(T)(Json json, T[string] values) {
  if (json.isObject) {
    values.each!((key, value) => json = json.set(key, value));
  }
  return json;
}

Json set(T)(Json json, string[] keys, T value) {
  keys.each!(key => json = json.set(key, value));
  return json;
}

Json set(T)(Json json, string key, T value) {
  return json.isObject
    ? set(json, key, value.toJson) : json;
}

Json set(Json json, string key, Json value) {
  if (json.isObject) {
    json[key] = value;
  }
  return json;
}
// #endregion Json

unittest {
  auto json = Json.emptyObject;
  json = json.set("a", "A").set("b", "B").set("c", "C");
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  writeln(json.toString);
  assert(json.hasAllKeys(["a", "b", "c"]));

  json = Json.emptyObject;
  json = json.set("a", Json("A")).set("b", Json("B")).set("c", Json("C"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.set(["a", "b", "c"], "x");
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json = json.set(["a", "b", "c"], Json("x"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json = json.set(["a": "A", "b": "B", "c": "C"]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json = json.set(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
// #endregion Json

// #region set
// Returns a new map with updated values for existing keys
/* ref set(K : string, V:
  Json, T:
  Json)(ref V[K] items, T[K] others, K[] keys = null) if (is(typeof(T) == Json)) {
  keys.length == 0
    ? others
    .each!((key, value) => items.set(key, value)) : keys
    .filter!(key => key in others)
    .each!(key => items.set(key, others[key]));

  return items;
}
 */
/*   // Returns a new map with updated values for existing keys
  ref set(K : string, V:Json, T)(ref V[K] items, T[K] others, K[] keys = null) if (!is(typeof(T) == Json)) {
    keys.length == 0
      ? others
      .each!((key, value) => items.set(key, value)) : keys
      .filter!(key => key in others)
      .each!(key => items.set(key, others[key]));

    return items;
  }

  // returns a updated map with new values
  ref set(K : string, V:
    Json, T)(ref V[K] items, K[] keys, V value) {
    keys.each!(key => items.set(key, value));
    return items;
  } */
