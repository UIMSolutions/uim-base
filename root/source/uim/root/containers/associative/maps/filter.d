/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.phobos.containers.maps.filter;

import uim.phobos;

mixin(Version!"test_uim_phobos");

@safe:

/**
  * Filters the map to include only the specified keys.
  *
  * Params:
  *   map = The map to filter.
  *   keys = The keys to include in the filtered map.
  *
  * Returns:
  *   A new map containing only the specified keys and their associated values.
  */
V[K] filterKeys(K, V)(V[K] map, K[] keys) {
  return filterMap(map, (K key, V value) @safe => map.hasKey(key));
}

/** 
  * Filters the map to include only the specified values.
  *
  * Params:
  *   map = The map to filter.
  *   values = The values to include in the filtered map.
  *
  * Returns:
  *   A new map containing only the key-value pairs where the value is in the specified values.
  */
V[K] filterValues(K, V)(V[K] map, V[] values) {
  return filterMap(map, (K key, V value) @safe => map.hasValue(value));
}

/** 
  * Filters the map based on a delegate function that evaluates each key-value pair.
  *
  * Params:
  *   map = The map to filter.
  *   filterFunc = A delegate function that takes a key and a value as parameters and returns a boolean indicating whether to include the key-value pair in the filtered map.
  *
  * Returns:
  *   A new map containing only the key-value pairs for which the delegate function returned true.
  */
V[K] filterMap(K, V)(V[K] map, bool delegate(K key, V value) @safe filterFunc) {
  V[K] results;
  foreach (key, value; map) {
    if (filterFunc(key, value)) {
      results[key] = value;
    }
  }
  return results;
}
