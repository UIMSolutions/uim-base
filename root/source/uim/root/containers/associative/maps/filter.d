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
  return filterMap(map, (K key, V value) @safe => map.hasKey(key) && filterFunc(key));
}

V[K] filterKeys(K, V)(V[K] map, K[] keys) {
  return map.filterMap((K key) => map.hasKey(key));
}

V[K] filterKeys(K, V)(V[K] map, bool delegate(K) @safe filterFunc) {
  return map.filterMap((K key) => map.hasKey(key) && filterFunc(key));
}
// #endregion filterKeys

// #region filterValues
V[K] filterValues(K, V)(V[K] map, V[] values, bool delegate(V) @safe filterFunc) {
  return map.filterMap((V value) => map.hasValue(value) && filterFunc(value));
}

V[K] filterValues(K, V)(V[K] map, V[] values) {
  return map.filterMap((V value) => map.hasValue(value));
}

V[K] filterValues(K, V)(V[K] map, bool delegate(V) @safe filterFunc) {
  return map.filterMap((V value) => map.hasValue(value) && filterFunc(value));
}
// #endregion filterValues

// #region filterMap
V[K] filterMap(K, V)(V[K] map, bool delegate(K) @safe filterFunc) {
  V[K] results;
  foreach (key, value; map) {
    if (filterFunc(key)) {
      results[key] = value;
    }
  }
  return results;
}

V[K] filterMap(K, V)(V[K] map, bool delegate(V) @safe filterFunc) {
  V[K] results;
  foreach (key, value; map) {
    if (filterFunc(value)) {
      results[key] = value;
    }
  }
  return results;
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
// #region filterMap
