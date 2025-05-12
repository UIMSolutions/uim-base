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

// #region json
mixin(GetJsonValue!("Json", "Json", "Json(null)"));

Json getJson(Json json, Json defaultValue = Json(null)) {
  return json;
}
// #endregion json

// #region set
// #region Json[string]
Json[string] setNull(Json[string] map, string key) {
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
// #endregion Json

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

Json set(T)(Json json, string key, T value) {
  return json.set(key, value.toJson);
}

Json set(T : Json)(Json json, string key, T value) {
  if (json.isNull) {
    json = Json.emptyObject;
  }
  json[key] = value;
  return json;
}
/* unittest {
  Json json = Json.emptyObject;
  assert(json.set("bool", true).getBoolean("bool"));
  assert(json.set("bool", true).getBoolean("bool"));
  assert(json.set("long", 1).getLong("long") == 1);
  assert(json.set("double", 0.1).getDouble("double") == 0.1);
  assert(json.set("string", "A").getString("string") == "A");
  assert(json.set("strings", ["x": "X", "y": "Y", "z": "Z"]) != Json(null));
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
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.update("a", Json("A"));
  json.update("b", Json("B")).update("c", Json("C"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json.update(["a", "b", "c"], "x");
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.update(["a", "b", "c"], Json("x"));
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.update(["a": "A", "b": "B", "c": "C"]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.update(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  auto newJson = Json.emptyObject;
  newJson.update(json);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
 */
// #endregion Json
// #endregion update

// #region merge
// #endregion merge

// #region remove
V[string] removeKey(V : Json)(V[string] items, string key) {
  if (hasKey(items, key)) {
    items.remove(key);
  }
  return items;
}
// #endregion remove
