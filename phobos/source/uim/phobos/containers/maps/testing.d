m/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
moduleodule uim.phobos.containers.maps.testing;

import uim.phobos;

mixin(Version!"test_uim_phobos");

@safe:

void assertEquals(K, V)(V[K] expected, V[K] actual) {
  assert(expected.length == actual.length, "Maps have different lengths.");
  foreach (key; expected.keys) {
    assert(actual.hasKey(key), "Actual map is missing key: " ~ to!string(key));
    assert(expected[key] == actual[key], "Values for key " ~ to!string(key) ~ " do not match.");
  }
}