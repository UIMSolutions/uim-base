/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.containers.associative.maps.testing;

import uim.root;

mixin(Version!"test_uim_root");

@safe:

/** 
  * Asserts that two associative arrays (maps) are equal in terms of keys and corresponding values.
  *
  * Params:
  *   expected = The expected associative array.
  *   actual   = The actual associative array to compare against the expected.
  *
  * Throws:
  *   An assertion error if the maps differ in length, keys, or values.
  */
void assertEquals(K, V)(V[K] expected, V[K] actual) {
  assert(expected.length == actual.length, "Maps have different lengths.");
  foreach (key; expected.keys) {
    assert(actual.hasKey(key), "Actual map is missing key: " ~ to!string(key));
    assert(expected[key] == actual[key], "Values for key " ~ to!string(key) ~ " do not match.");
  }
}

/** 
  * Asserts that the provided associative array (map) is not null.
  *
  * Params:
  *   map = The associative array to check.
  *
  * Throws:
  *   An assertion error if the map is null.
  */
void assertNotNull(K, V)(V[K] map) {
  assert(map !is null, "Map is null.");
}

/** 
  * Asserts that the provided associative array (map) is null.
  *
  * Params:
  *   map = The associative array to check.
  *
  * Throws:
  *   An assertion error if the map is not null.
  */
void assertNull(K, V)(V[K] map) {
  assert(map is null, "Map is not null.");
}