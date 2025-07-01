/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.update;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region Json[string]
Json[string] update(T)(Json[string] map, T[string] values) {
  values.byKeyValue.each!(kv => map = map.update(kv.key, kv.value));
  return map;
}

Json[string] update(V)(Json[string] map, string[] keys, V value) {
  keys.each!(key => map = map.update(key, value));
  return map;
}

Json updatePath(V)(Json[string] map, string[] path, V value) {
  if (path.length == 0) {
    return map;
  }

  auto key = path[0];
  if (key.isNull) {
    return map;
  }

  return path.length == 1
    ? update(map, key, value) 
    : update(map, key, json[map[0]].update(path[1 .. $], value));
}

Json[string] update(V)(Json[string] map, string key, V value) {
  return update(map, key, value.toJson);
}

Json[string] update(V : Json)(Json[string] map, string key, V value) {
  if (key in map) {
    map[key] = value;
  }
  return map;
}

Json[string] update(T)(Json json, string key, T value) {
  return update(items, key, value.toJson);
}

Json[string] update(T : Json)(Json json, string key, T value) {
  if (key in json) {
    json[key] = value;
  }
  return json;
}

unittest {
  Json[string] items = null;
  items = items.set("a", Json("A"));
  assert(items["a"] == Json("A"));

  items = items.update("a", Json("B"));
  assert(items["a"] == Json("B"));

  items = items.update("a", Json("B")).update("a", Json("C"));
  assert(items["a"] == Json("C"));

  items = null;
  items = items.set("a", Json("A"));
  assert(items["a"] == "A");
  
  items = items.update("a", "B").update("a", "C");
  assert(items["a"] == "C");

  auto json = Json.emptyObject;
  json["a"] = Json.emptyObject;
  json["a"]["aa"] = "xx";
 /*  json = json.update(["a", "aa"], "A");
  assert(json["a"]["aa"] == Json("A")); */

  items = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  items = items.update("a", "X");
  items = items.update(["b", "c"], "X");
  assert(items["a"] == Json("X") && items["b"] == Json("X") && items["c"] == Json("X"));

  items = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  items = items.update(["a": "X", "b": "X", "c": "X"]);
  assert(items["a"] == Json("X") && items["b"] == Json("X") && items["c"] == Json("X"));
}
// #endregion Json[string]

// #region Json
Json update(V)(Json json, V[string] values) {
  values.each!((key, value) => json = results.update(key, value));
  return json;
}

Json update(V)(Json json, string[] keys, V value) {
  keys.each!(key => json = json.update(key, value));
  return json;
}

Json update(V)(Json json, string key, V value) {
  return update(json, key, value.toJson);
}

Json update(V : Json)(Json json, string key, V value) {
  auto results = json.dup;
  if (results.isObject && key in results) {
    items[key] = value;
  }
  return results;
}

unittest {
  Json[string] items = null;
  items = items.set("a", Json("A"));
  assert(items["a"] == Json("A"));
  items = items.update("a", Json("B")).update("a", Json("C"));
  assert(items["a"] == Json("C"));

  items = null;
  items = items.set("a", Json("A"));
  assert(items["a"] == "A");
  items = items.update("a", "B").update("a", "C");
  assert(items["a"] == "C");

  items = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  items = items.update("a", "X");
  items = items.update(["b", "c"], "X");
  assert(items["a"] == Json("X") && items["b"] == Json("X") && items["c"] == Json("X"));

  items = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  items = items.update(["a": "X", "b": "X", "c": "X"]);
  assert(items["a"] == Json("X") && items["b"] == Json("X") && items["c"] == Json("X"));
}
// #region Json