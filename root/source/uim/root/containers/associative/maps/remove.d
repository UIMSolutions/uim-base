/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.containers.associative.maps.remove;

import uim.root;

mixin(Version!"test_uim_root");

@safe:

// #region Keys
/** Removes entries from the map based on specified keys.

  * Params:
  *   map = The original map.
  *   keys = The keys of the entries to remove.
  *
  * Returns:
  *   A new map with the specified keys removed.
  */
V[K] removeKey(K, V)(V[K] map, K[] keys) {
  return removeMap(map, (K key, V value) @safe => keys.hasValue(key));
}
/// 
unittest {
  int[string] testMap = [ "a": 1, "b": 2, "c": 3, "d": 4 ];

  // Test removeKeys
  int[string] result1 = removeKey(testMap, ["b", "d"]);
  int[string] expected1 = [ "a": 1, "c": 3 ];
  assertEquals(expected1, result1);

  // Test removeValue
  int[string] result2 = removeValue(testMap, [1, 3]);
  int[string] expected2 = [ "b": 2, "d": 4 ];
  assertEquals(expected2, result2);
}
// #endregion Keys

// #region Values
/** Removes entries from the map based on specified values.

  * Params:
  *   map = The original map.
  *   values = The values of the entries to remove.
  *
  * Returns:
  *   A new map with the specified values removed.
  */
V[K] removeValue(K, V)(V[K] map, V[] values) {
  return removeMap(map, (K key, V value) @safe => values.hasValue(value));
}
///
unittest {
  int[string] testMap = [ "a": 1, "b": 2, "c": 3, "d": 4 ];

  // Test removeKeys
  int[string] result1 = removeKey(testMap, ["b", "d"]);
  int[string] expected1 = [ "a": 1, "c": 3 ];
  assertEquals(expected1, result1);

  // Test removeValue
  int[string] result2 = removeValue(testMap, [1, 3]);
  int[string] expected2 = [ "b": 2, "d": 4 ];
  assertEquals(expected2, result2);
}
// #endregion Values

// #region Map
/** Removes entries from the map based on a custom removal function.

  * Params:
  *   map = The original map.
  *   removeFunc = A delegate function that determines whether to remove an entry.
  *                It takes a key and a value as parameters and returns true to remove the entry, false to keep it.
  *
  * Returns:
  *   A new map with the entries removed based on the custom function.
  */
V[K] removeMap(K, V)(V[K] map, bool delegate(K key, V value) @safe removeFunc) {
  V[K] results;
  foreach (key, value; map) {
    if (!removeFunc(key, value)) {
      results[key] = value;
    }
  }
  return results;
}
///
unittest {
  int[string] testMap = [ "a": 1, "b": 2, "c": 3, "d": 4 ];

  // Test removeKeys
  int[string] result1 = removeKey(testMap, ["b", "d"]);
  int[string] expected1 = [ "a": 1, "c": 3 ];
  assertEquals(expected1, result1);

  // Test removeValue
  int[string] result2 = removeValue(testMap, [1, 3]);
  int[string] expected2 = [ "b": 2, "d": 4 ];
  assertEquals(expected2, result2);

  // Test removeMap
  int[string] result3 = removeMap(testMap, (string key, int value) @safe => value % 2 == 0);
  int[string] expected3 = [ "a": 1, "c": 3 ];
  assertEquals(expected3, result3);
}
// #endregion Map