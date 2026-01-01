/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.containers.associative.maps.filter;

import uim.root;

mixin(Version!"test_uim_root");

@safe:

// #region filterKeys
V[K] filterKeys(K, V)(V[K] map, K[] keys, bool delegate(K) @safe filterFunc) {
  return map.filterKeys(keys).filterKeys(filterFunc);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterKeys with keys and filterFunc");

  int[string] map = ["one": 1, "two": 2, "three": 3, "four": 4];
  auto filtered = map.filterKeys(["two", "three", "five"],
    (string key) @safe => key.length == 3);
  assert(filtered.length == 2);
  assert(filtered["two"] == 2);
  assert(filtered["three"] == 3);
}

V[K] filterKeys(K, V)(V[K] map, K[] keys) {
  return map.filterMap((K key, V value) => map.hasKey(key));
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterKeys with keys");

  int[string] map = ["one": 1, "two": 2, "three": 3, "four": 4];
  auto filtered = map.filterKeys(["two", "three", "five"]);
  assert(filtered.length == 2);
  assert(filtered["two"] == 2);
  assert(filtered["three"] == 3);
}

V[K] filterKeys(K, V)(V[K] map, bool delegate(K) @safe filterFunc) {
  return map.filterMap((K key, V value) => filterFunc(key));
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterKeys with filterFunc");

  int[string] map = ["one": 1, "two": 2, "three": 3, "four": 4];
  auto filtered = map.filterKeys((string key) @safe => key.length == 3);
  assert(filtered.length == 2);
  assert(filtered["one"] == 1);
  assert(filtered["two"] == 2);
}
// #endregion filterKeys

// #region filterValues
V[K] filterValues(K, V)(V[K] map, V[] values, bool delegate(V) @safe filterFunc) {
  return map.filterValues(values).filterValues(filterFunc);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterValues with values and filterFunc");

  string[string] map = ["a": "apple", "b": "banana", "c": "cherry", "d": "date"];
  auto filtered = map.filterValues(["banana", "cherry", "fig"],
    (string value) @safe => value.length > 5);
  assert(filtered.length == 1);
  assert(filtered["cherry"] == "cherry");
}

V[K] filterValues(K, V)(V[K] map, V[] values) {
  return map.filterMap((K key, V value) => values.hasValue(value));
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterValues with values");

  string[string] map = ["a": "apple", "b": "banana", "c": "cherry", "d": "date"];
  auto filtered = map.filterValues(["banana", "cherry", "fig"]);
  assert(filtered.length == 2);
  assert(filtered["banana"] == "banana");
  assert(filtered["cherry"] == "cherry");
}

V[K] filterValues(K, V)(V[K] map, bool delegate(V) @safe filterFunc) {
  return map.filterMap((K key, V value) => filterFunc(value));
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterValues with filterFunc");

  string[string] map = ["a": "apple", "b": "banana", "c": "cherry", "d": "date"];
  auto filtered = map.filterValues((string value) @safe => value.length == 5);
  assert(filtered.length == 2);
  assert(filtered["apple"] == "apple");
  assert(filtered["cherry"] == "cherry");
}
// #endregion filterValues

// #region filterMap
V[K] filterMap(K, V)(V[K] map, V[K] filteringMap, bool delegate(K, V) @safe filterFunc) {
  return map.filterMap(filteringMap).filterMap(filterFunc);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterMap with filteringMap and filterFunc");

  string[string] map = ["a": "apple", "b": "banana", "c": "cherry", "d": "date"];
  auto filtered = map.filterMap(["b": "banana", "c": "cherry", "e": "elderberry"],
    (string key, string value) @safe => value.length > 5);
  assert(filtered.length == 1);
  assert(filtered["cherry"] == "cherry");
}

V[K] filterMap(K, V)(V[K] map, V[K] filteringMap) {
  V[K] results;
  foreach (key, value; filteringMap) {
    if (map.hasKey(key) && map[key] == value) {
      results[key] = value;
    }
  }
  return results;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterMap with filterFunc");

  string[string] map = ["a": "apple", "b": "banana", "c": "cherry", "d": "date"];
  auto filtered = map.filterMap((string key, string value) @safe => value.length > 5);
  assert(filtered.length == 2);
  assert(filtered["banana"] == "banana");
  assert(filtered["cherry"] == "cherry");
}

V[K] filterMap(K, V)(V[K] map, bool delegate(K, V) @safe filterFunc) {
  V[K] results;
  foreach (key, value; map) {
    if (filterFunc(key, value)) {
      results[key] = value;
    }
  }
  return results;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing filterMap with filterFunc");

  string[string] map = ["a": "apple", "b": "banana", "c": "cherry", "d": "date"];
  auto filtered = map.filterMap((string key, string value) @safe => value.length == 5);
  assert(filtered.length == 2);
  assert(filtered["apple"] == "apple");
  assert(filtered["cherry"] == "cherry");
}
// #endregion filterMap
