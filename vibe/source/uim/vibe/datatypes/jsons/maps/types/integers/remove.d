/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.maps.types.integers.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[string] removeIntegers(Json[string] items, bool delegate(Json json) @safe removeFunc) {
  Json[string] results;
  foreach (k, v; items.byKeyValue) {
    if (!v.isInteger && !removeFunc(v)) {
      results[k] = v;
    }
  }
  return results;
}

Json[string] removeIntegers(Json[string] items, string[] keys) {
  Json[string] results;
  foreach (k, v; items.byKeyValue) {
    if (!v.isInteger && !(k in keys)) {
      results[k] = v;
    }
  }
  return results;
}   

Json[string] removeIntegers(Json[string] items) {
  Json[string] results;
  foreach (k, v; items.byKeyValue) {
    if (!v.isInteger) {
      results[k] = v;
    }
  }
  return results;
}