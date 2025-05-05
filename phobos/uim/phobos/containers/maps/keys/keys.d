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
    assert(testMap2.hasKey(1) && !testMap2.hasKey(5));

    assert(testMap.hasAnyKeys(["a", "b"]) && testMap.hasAnyKeys(["a", "x"]));
    assert(testMap.hasAllKeys(["a", "b"]) && !testMap.hasAllKeys(["a", "x"]));

    auto stringMap = ["a": "1", "b": "2", "c": "3", "d": "4"];
    assert(stringMap.hasKey("a") && !stringMap.hasKey("x"));

    assert(stringMap.hasAnyKeys(["a", "b"]) && stringMap.hasAnyKeys(["a", "x"]));
    assert(stringMap.hasAllKeys(["a", "b"]) && !stringMap.hasAllKeys(["a", "x"]));

    auto jsonMap = ["a": Json(1), "b": Json(2), "c": Json(3), "d": Json(4)];
    assert(jsonMap.hasKey("a") && !jsonMap.hasKey("x"));
    assert(jsonMap.hasAnyKeys(["a", "b"]) && jsonMap.hasAnyKeys(["a", "x"]));
    assert(jsonMap.hasAllKeys(["a", "b"]) && !jsonMap.hasAllKeys(["a", "x"]));
  } 
// #endregion has

// #region removeKey(s)
  V[K] removeKeys(K, V)(V[K] items, K[] keys) {
    keys.each!(key => removeKey(items, key));
    return items;
  }

  V[K] removeKey(K, V)(V[K] items, K key) {
    if (hasKey(items, key)) {
      items.remove(key);
    }
    return items;
  }

  V[K] removeKey(K: string, V: string)(V[K] items, K key) {
    if (key in items) {
      items.remove(key);
    }
    return items;
  }

  unittest {
    auto testMap = ["a": 1, "b": 2, "c": 3, "d": 4];
    assert(testMap.hasAllKeys(["a", "b", "c", "d"]));
    testMap.removeKey("a");
    assert(testMap.hasAllKeys(["b", "c", "d"]) && !testMap.hasKey("a"));
    
    testMap = ["a": 1, "b": 2, "c": 3, "d": 4];
    assert(testMap.hasAllKeys(["a", "b", "c", "d"]));
    testMap.removeKeys(["b", "c"]);
    assert(testMap.hasAllKeys(["a", "d"]) && !testMap.hasAnyKey(["b", "c"]));

    auto stringMap = ["a": "1", "b": "2", "c": "3", "d": "4"];
    assert(stringMap.hasAllKeys(["a", "b", "c", "d"]));
    stringMap.removeKey("a");
    assert(stringMap.hasAllKeys(["b", "c", "d"]) && !stringMap.hasKey("a"));

    stringMap = ["a": "1", "b": "2", "c": "3", "d": "4"];
    assert(stringMap.hasAllKeys(["a", "b", "c", "d"]));
    stringMap.removeKeys(["b", "c"]);
    assert(stringMap.hasAllKeys(["a", "d"]) && !stringMap.hasAnyKey(["b", "c"]));

    auto jsonMap = ["a": Json(1), "b": Json(2), "c": Json(3), "d": Json(4)];
    assert(jsonMap.hasAllKeys(["a", "b", "c", "d"]));
    jsonMap.removeKey("a");
    assert(jsonMap.hasAllKeys(["b", "c", "d"]) && !jsonMap.hasKey("a"));

    jsonMap = ["a": Json(1), "b": Json(2), "c": Json(3), "d": Json(4)];
    assert(jsonMap.hasAllKeys(["a", "b", "c", "d"]));
    jsonMap.removeKeys(["b", "c"]);
    assert(jsonMap.hasAllKeys(["a", "d"]) && !jsonMap.hasAnyKey(["b", "c"]));
  }
// #endregion removeKey(s)
