/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.containers.maps.keys.keys;

mixin(Version!("test_uim_phobos"));

import uim.phobos;
@safe:

// #region has
  // Returns true if the map has all the specified keys
  bool hasAllKeys(K, V)(V[K] map, K[] keys) {
    return keys.all!(key => map.hasKey(key));
  }

  // Returns true if the map has any of the specified keys
  bool hasAnyKeys(K, V)(V[K] map, K[] keys) {
    return keys.any!(key => map.hasKey(key));
  }

  // Returns true if the map has the specified key
  bool hasKey(K, V)(V[K] map, K key) {
    return (key in map) ? true : false;
  }

  unittest {
    auto testMap = ["a": 1, "b": 2, "c": 3, "d": 4];
    assert(testMap.hasKey("a") && !testMap.hasKey("x"));

    auto testMap2 = [1: "a", 2: "b", 3: "c", 4: "d"];
    assert(testMap2.hasKey(1) && !testMap.hasKey(5));

    assert(testMap.hasAnyKey(["a", "b"]) && testMap.hasAnyKey(["a", "x"]));
    assert(testMap.hasAnyKey("a", "b") && testMap.hasAnyKey("a", "x"));

    assert(testMap.hasAllKeys(["a", "b"]) && !testMap.hasAllKeys(["a", "x"]));
    assert(testMap.hasAllKeys("a", "b") && !testMap.hasAllKeys("a", "x"));

    auto stringMap = ["a": "1", "b": "2", "c": "3", "d": "4"];
    assert(stringMap.hasKey("a") && !stringMap.hasKey("x"));

    assert(stringMap.hasAnyKey(["a", "b"]) && stringMap.hasAnyKey(["a", "x"]));
    assert(stringMap.hasAnyKey("a", "b") && stringMap.hasAnyKey("a", "x"));

    assert(stringMap.hasAllKeys(["a", "b"]) && !stringMap.hasAllKeys(["a", "x"]));
    assert(stringMap.hasAllKeys("a", "b") && !stringMap.hasAllKeys("a", "x"));

    auto jsonMap = ["a": Json(1), "b": Json(2), "c": Json(3), "d": Json(4)];
    assert(jsonMap.hasKey("a") && !jsonMap.hasKey("x"));

    assert(jsonMap.hasAnyKey(["a", "b"]) && jsonMap.hasAnyKey(["a", "x"]));
    assert(jsonMap.hasAnyKey("a", "b") && jsonMap.hasAnyKey("a", "x"));

    assert(jsonMap.hasAllKeys(["a", "b"]) && !jsonMap.hasAllKeys(["a", "x"]));
    assert(jsonMap.hasAllKeys("a", "b") && !jsonMap.hasAllKeys("a", "x"));
  } 
// #endregion has
