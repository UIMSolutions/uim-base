/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.merge;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region Json[string]
Json[string] merge(T)(Json[string] items, T[string] values) {
  values.each!((key, value) => items = items.merge(key, value));
  return items;
}

Json[string] merge(T)(Json[string] items, string[] keys, T value) {
  keys.each!(key => results = items.merge(key, value));
  return items;
}

Json mergePath(T)(Json[string] items, string[] path, T value) {
  if (path.length == 0) {
    return items;
  }

  auto key = path[0];
  if (key.isNull) {
    return items;
  }

  return path.length == 1
    ? merge(items, key, value) : merge(items, key, json[items[key]].mergePath(path[1 .. $], value));
}

Json[string] merge(T)(Json[string] items, string key, T value) {
  return merge(items, key, value.toJson);
}

Json[string] merge(T : Json)(Json[string] items, string key, T value) {
  auto results = items.dup;
  if (key !in results) {
    results[key] = value;
  }
  return results;
}
unittest {
/*   Json[string] map = ["a": "A", "b": "B", "c": "C"];
  assert(map.merge("a", "X") == ["a": "A", "b": "B", "c": "C"]);
  assert(map.merge("d", "D") == ["a": "A", "b": "B", "c": "C", "d": "D"]);
  assert(map.merge(["a", "b"], "-") == ["a": "-", "b": "-", "c": "C"]);
  assert(map.merge(["a", "b"], ["x": "-", "y": "-"]) == ["a": "-", "b": "-", "c": "C"]);
 */}
// #endregion Json[string]

// #region Json
Json merge(Json json, Json map) {
  if (!json.isObject) {
    return json;
  }

  if (!map.isObject) {
    return json;
  }

  foreach (key, value; map.byKeyValue) {
    json = json.merge(key, value);
  }

  return json;
}

Json merge(V)(Json json, V[string] values) {
  if (!json.isObject) {
    return json;
  }

  values.each!((key, value) => json = json.merge(key, value));
  return json;
}

Json mergePath(T)(Json json, string[] path, T value) {
  if (!json.isObject) {
    return json;
  }

  if (path.length == 0) {
    return json;
  }

  // path.length > 0
  auto key = path[0];
  if (key.isNull) {
    return json;
  }

  if (path.length == 1) {
    return json.merge(key, value);
  }

  // path.length > 1
  json = json.merge(key, json[key].mergePath(path[1..$], value));
  return json;
}

Json merge(V)(Json json, string[] keys, V value) {
  if (!json.isObject) {
    return json;
  }

  keys.each!(key => json = json.merge(key, value));
  return json;
}

Json merge(V)(Json json, string key, V value) {
  if (!json.isObject) {
    return json;
  }

  if (!json.hasKey(key)) {
    json[key] = value.toJson;
  }

  return json;
}

Json merge(T : Json)(Json json, string key, T value) {
  if (json == Json(null)) {
    json = Json.emptyObject;
  }

  if (!json.isObject) {
    return json;
  }

  if (!json.hasKey(key)) {
    json[key] = value;
  }

  return json;
}

unittest {
  Json json = Json.emptyObject.merge("a", Json("A"));
  assert(json["a"] == Json("A"));

  json = json.merge("b", Json("B")).merge("c", Json("C"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.merge("a", Json("X"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject.merge("a", "A");
  assert(json["a"] == Json("A"));

  json = json.merge("b", "B").merge("c", "C");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.merge("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject.merge("a", "A");
  assert(json["a"] == Json("A"));

  json = json.merge(["b", "c"], "X");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));

  json = json.merge("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));

  json = json.merge(["b", "c"], "-");
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));

  json = Json.emptyObject.merge("a", "A");
  assert(json["a"] == Json("A"));

  json = json.merge(["b": "B", "c": "C"]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.merge("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.merge(["b": "X", "c": "X"]);
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
