/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.remove;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

// #region Json[string]
Json[string] removeAll(Json[string] map) {
  // Collect keys first to avoid mutating during iteration
  auto keys = map.keys.array;
  keys.each!(key => map.remove(key));
  return map;
}

Json[string] remove(Json[string] map, string[] keys) {
  keys.each!(key => map.remove(key));
  return map;
}

Json[string] remove(Json[string] map, string key) {
  if (map is null) {
    return map;
  }

  if (key in map) {
    map.remove(key);
  }
  return map;
}

unittest {
    // Test removeAll(Json[string])
    Json[string] map = [
        "a": Json("1"),
        "b": Json("2"),
        "c": Json("3")
    ];
    auto cleared = removeAll(map.dup);
    assert(cleared.length == 0);

    // Test remove(Json[string], string[])
    map = [
        "a": Json("1"),
        "b": Json("2"),
        "c": Json("3")
    ];
    auto removed = remove(map.dup, ["a", "c"]);
    assert(removed.length == 1);
    assert("b" in removed);
    assert(!("a" in removed));
    assert(!("c" in removed));

    // Test remove(Json[string], string)
    map = [
        "a": Json("1"),
        "b": Json("2"),
        "c": Json("3")
    ];
    auto removedOne = remove(map.dup, "b");
    assert(removedOne.length == 2);
    assert("a" in removedOne);
    assert("c" in removedOne);
    assert(!("b" in removedOne));

    // Test remove(Json[string], string) with non-existent key
    map = [
        "a": Json("1"),
        "b": Json("2")
    ];
    auto removedNonExistent = remove(map.dup, "z");
    assert(removedNonExistent.length == 2);
    assert("a" in removedNonExistent);
    assert("b" in removedNonExistent);

    // Test remove(Json[string], string) with null map
    Json[string] nullMap;
    auto result = remove(nullMap, "a");
    assert(result is nullMap);
}
// #endregion Json[string]

// #region Json[]
Json[] removeAll(Json[] list) {
  list = [];
  return list;
}

Json[] remove(Json[] list, size_t[] indices) {
  indices.sort!("b>a").each!(index => list.remove(index));
  return list;
}

Json[] remove(Json[] list, size_t index) {
  if (list.length == 0) {
    return list;
  }

  if (list.length > index) {
    list.remove(index);
  }
  return list;
}
// #endregion Json[]


// #region Json
Json removeAll(Json json) {
  if (json.isObject) {
    json = Json.emptyObject;
  }
  else if (json.isArray) {
    json = Json.emptyArray;
  }
  else {
    json = Json(null);
  }

  return json;
}

Json remove(Json json, string[] keys) {
  keys.each!(k => json.remove(k));
  return json;
}

Json remove(Json json, string key) {
  if (!json.isObject) {
    return json;
  }

  json.remove(key);
  return json;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.hasKey("a"));
  json.remove("a");
  assert(!json.hasKey("a"));

  json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(!json.hasKey("x"));
  json.remove("x");
  assert(!json.hasKey("x"));
  json.remove("x");
  assert(json.hasKey("a"));
}
// #endregion Json
