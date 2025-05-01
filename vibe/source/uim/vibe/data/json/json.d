/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.json;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region create
// #endregion create

// #region set
// #region Json
Json setNull(Json json, string key) {
  return json.set(key, Json(null));
}

Json set(V)(Json map, string key, V value) {
  return map.set(key, value.toJson);
}

Json set(V)(Json json, string key, V[] value) {
  return map.set(key, value.toJson);
}

Json set(V)(Json json, string key, V[string] value) {
  return map.set(key, value.toJson);
}

Json set(V : Json)(Json map, string key, V value) {
  map[key] = value;
  return map;
}
/* unittest {
  Json json = Json.emptyObject;
  assert(json.set("bool", true).getBoolean("bool"));
  assert(json.set("bool", true).getBoolean("bool"));
  assert(json.set("long", 1).getLong("long") == 1);
  assert(json.set("double", 0.1).getDouble("double") == 0.1);
  assert(json.set("string", "A").getString("string") == "A");
  assert(json.set("strings", ["x": "X", "y": "Y", "z": "Z"]) != Json(null));
  writeln(json);
} */
// #endregion Json

// #endregion set

// #region update
// #region Json
Json update(Json json, Json map) {
  if (!json.isObject || !map.isObject) {
    return json;
  }

  foreach (key, value; map.byKeyValue) {
    json = json.update(key, value);
  }
  return json;
}

Json update(V)(Json json, V[string] values) {
  if (!json.isObject) {
    return json;
  }

  foreach (key, value; values.byKeyValue) {
    json = json.update(key, value);
  }

  return json;
}

Json update(V)(Json json, string[] keys, V value) {
  if (!json.isObject) {
    return json;
  }

  keys.each!(key => json.update(key, value));
  return json;
}

Json update(V)(Json json, string key, V value) {
  return json.isObject && json.hasKey(key)
    ? json.set(key, value) : json;
}

// TODO
/* unittest {
  auto json = Json.emptyObject;
  json.update("a", "A");
  json.update("b", "B").update("c", "C");
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.update("a", Json("A"));
  json.update("b", Json("B")).update("c", Json("C"));
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json.update(["a", "b", "c"], "x");
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.update(["a", "b", "c"], Json("x"));
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.update(["a": "A", "b": "B", "c": "C"]);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.update(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  auto newJson = Json.emptyObject;
  newJson.update(json);
  assert(json.hasAllKeys("a", "b", "c"));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
 */
// #endregion Json
// #endregion update

// #region merge
// #region Json[string]
// #endregion Json[string]

// #region Json[]
// #endregion Json[]

// #region Json
// #endregion Json
// #endregion merge

// #region remove
// #region Json[string]
// #endregion Json[string]

// #region Json[]
// #endregion Json[]

// #region Json
V[K] removeKey(K: string, V : Json)(V[K] items, K key) {
  return key in items, key
    ? (items.remove(key))
    : items;
}
unittest {
  // TODO: Add unittest for removeKey
}
// #endregion Json
// #endregion remove
