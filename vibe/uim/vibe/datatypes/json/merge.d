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
  foreach (key, value; values.byKeyValue) {
    if (key.isNull) {
      continue; // Skip null keys
    }
    items.merge(key, value);
  }
  // values.each!((key, value) => items.merge(key, value));
  return items;
}

Json[string] merge(T)(Json[string] items, string[] keys, T value) {
  keys.each!(key => items.merge(key, value));
  return items;
}

// #region mergePath(T)(Json[string] items, string[] path, T value)
Json[string] mergePath(T)(Json[string] items, string[] path, T value) {
  if (path.length == 0) {
    return items;
  }

  // path.length > 0
  auto key = path[0];
  if (key.isNull) {
    return items;
  }

  if (path.length == 1) {
    return items.merge(key, value);
  }

  // path.length > 1
  if (!items.hasKey(key)) {
    items.set(key, Json.emptyObject);
  }
  if (!items.isObject(key)) {
    // If the existing value is not an object, we cannot merge further.
    return items; // Return original items without modification.
  }

  Json json = items[key];
  return items.set(key, json.mergePath(path[1 .. $], value));
}
///
unittest { // Test auto mergePath(T)(Json[string] items, string[] path, T value)
  // Test: mergePath with null key in path returns original items
  Json[string] items = ["a": Json("A")];
  items.mergePath([null], "X");
  assert(items == ["a": Json("A")]);

  // Test: mergePath with single key, key does not exist
  items = ["a": Json("A")];
  items.mergePath(["b"], "B");
  assert(items == ["a": Json("A"), "b": Json("B")]);

  // Test: mergePath with single key, key exists (should not overwrite)
  items = ["a": Json("A")];
  items.mergePath(["a"], "X");
  assert(items == ["a": Json("A")]);

  // Test: mergePath with nested path, intermediate key exists and is object
  items = ["a": Json(["x": Json("X")])];
  items.mergePath(["a", "y"], "Y");
  assert(items["a"].isObject && items["a"]["x"] == Json("X") && items["a"]["y"] == Json("Y"));

  // Test: mergePath with nested path, intermediate key does not exist
  items = ["a": Json("A")];
  items.mergePath(["b", "c"], "C");
  assert(items["a"] == Json("A"));
  writeln(items.toString);
  assert(items["b"].isObject && items["b"]["c"] == Json("C"));

  // Test: mergePath with nested path, intermediate key exists but is not object
  Json[string] items7 = ["a": Json("A")];
  auto result7 = items7.mergePath(["a", "b"], "B");
  // Since items7["a"] is not an object, mergePath should not add "b"
  assert(result7 == items7);

  // Test: mergePath with more than two levels
  Json[string] items8;
  items8.mergePath(["x", "y", "z"], 42);
  // TODO 
  /* writeln("--- items8: ", items8.toString);
  assert(items8["x"].isObject);
  assert(items8["x"]["y"].isObject);
  assert(items8["x"]["y"]["z"] == Json(42)); */
}
// #endregion

Json[string] merge(T)(Json[string] items, string key, T value) {
  return merge(items, key, value.toJson);
}

// #region merge(T : Json)(Json[string] items, string key, T value)
Json[string] merge(T : Json)(Json[string] map, string key, T value) {
  if (map is null) {
    map = [key: value.toJson];
    return map;
  }
  return (key !in map)
    ? map.set(key, value) : map;
}
/// 
unittest {
  // Test: Adding a new key should insert the value
  Json[string] items = ["a": Json("A")];
  items.merge("b", Json("B"));
  assert(items == ["a": Json("A"), "b": Json("B")]);

  // Test: Adding an existing key should not overwrite
  items = ["a": Json("A")];
  items.merge("a", Json("X"));
  assert(items == ["a": Json("A")]);

  // Test: Adding to an empty map
  // Json[string] items2;
  // items2.merge("z", Json("Z"));
  // writeln("items2: ", items2.toString);
  // assert(items2 == ["z": Json("Z")]);

  // Test: Adding multiple different keys
  items = ["x": Json("X")];
  items.merge("y", Json("Y")).merge("z", Json("Z"));
  assert(items == ["x": Json("X"), "y": Json("Y"), "z": Json("Z")]);

  // Test: Key is present but value is null
  items = ["n": Json(null)];
  items.merge("n", Json("N"));
  assert(items == ["n": Json(null)]);

  // Test: Key is not present, value is null
  // Json[string] items3;
  // items3.merge("n", Json(null));
  // assert(items3 == ["n": Json(null)]);
}
// #endregion Json[string]

// #region Json
auto merge(ref Json json, Json map) {
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

auto merge(V)(ref Json json, V[string] values) {
  if (!json.isObject) {
    return json;
  }

  values.each!((key, value) => json = json.merge(key, value));
  return json;
}

auto mergePath(T)(ref Json json, string[] path, T value) {
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
  return json.merge(key, json[key].mergePath(path[1 .. $], value));
}

auto merge(V)(ref Json json, string[] keys, V value) {
  if (!json.isObject) {
    return json;
  }

  keys.each!(key => json.merge(key, value));
  return json;
}

// #region merge(T)(ref Json json, string key, T value)
auto merge(T)(ref Json json, string key, T value) {
  if (json == Json(null)) {
    json = Json.emptyObject;
  }

  if (!json.isObject) {
    return json;
  }

  return json.hasKey(key)
    ? json : json.set(key, value);
}
///
unittest {
  { // Test: json is null, should create object and add key
    Json json = Json(null);
    json.merge("foo", "bar");
    assert(json.isObject);
    assert(json["foo"] == Json("bar"));
  }
  { // Test: json is not an object (e.g., a string), should return original json
    Json json = Json("not an object");
    json.merge("foo", "bar");
    assert(json == Json("not an object"));
  }
  { // Test: json is an object, key does not exist, should add key
    Json json = Json.emptyObject;
    json.merge("a", 123);
    assert(json.isObject);
    assert(json["a"] == Json(123));
  }

  { // Test: json is an object, key exists, should not overwrite
    Json json = Json(["x": Json(1)]);
    json.merge("x", 999);
    assert(json["x"] == Json(1));
  }

  { // Test: json is an object, add multiple keys
    Json json = Json.emptyObject;
    json.merge("first", true);
    json.merge("second", false);
    assert(json["first"] == Json(true));
    assert(json["second"] == Json(false));
  }
  { // Test: value is null, should add key with null value
    Json json = Json.emptyObject;
    json.merge("nullkey", Json(null));
    assert(json["nullkey"] == Json(null));
  }
}
// #endregion

unittest {
  Json json = Json.emptyObject;
  json.merge("a", Json("A"));
  assert(json["a"] == Json("A"));

  // TODO: Fix this test
  // json = json.merge("b", Json("B")).merge("c", Json("C"));
  // assert(json.hasAllKeys(["a", "b", "c"]));
  // assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.merge("a", Json("X"));
  assert(json["a"] == Json("A"));

  json = Json.emptyObject;
  json.merge("a", "A");
  assert(json["a"] == Json("A"));

  // TODO: Fix this test
  // json = json.merge("b", "B").merge("c", "C");
  // assert(json.hasAllKeys(["a", "b", "c"]));
  // assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.merge("a", "X");
  assert(json["a"] == Json("A"));

  json = Json.emptyObject;
  json.merge("a", "A");
  json.merge("a", "A");
  assert(json["a"] == Json("A"));

  json = json.merge(["b", "c"], "X");
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));

  json = json.merge("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));

  json = json.merge(["b", "c"], "-");
  assert(json["a"] == Json("A") && json["b"] == Json("X") && json["c"] == Json("X"));

  json = Json.emptyObject;
  json.merge("a", "A");
  assert(json["a"] == Json("A"));

  json = json.merge(["b": "B", "c": "C"]);
  assert(json.hasAllKeys(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.merge("a", "X");
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = json.merge(["b": "X", "c": "X"]);
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
