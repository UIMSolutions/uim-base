/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.maps.types.undefineds.remove;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[string] removeUndefineds(Json[string] items, bool delegate(Json json) @safe removeFunc) {
  Json[string] results;
  foreach (k, v; items.byKeyValue) {
    if (!v.isUndefined && !removeFunc(v)) {
      results[k] = v;
    }
  }
  return results;
}

Json[string] removeUndefineds(Json[string] items, string[] keys) {
  Json[string] results;
  foreach (k, v; items.byKeyValue) {
    if (!v.isUndefined && !(k in keys)) {
      results[k] = v;
    }
  }
  return results;
}   

Json[string] removeUndefineds(Json[string] items) {
  Json[string] results;
  foreach (k, v; items.byKeyValue) {
    if (!v.isUndefined) {
      results[k] = v;
    }
  }
  return results;
}