/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.maps.types.scalars.remove;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json[string] removeScalars(Json[string] items, bool delegate(Json json) @safe removeFunc) {
  Json[string] results;
  foreach (k, v; items.byKeyValue) {
    if (!v.isScalar && !removeFunc(v)) {
      results[k] = v;
    }
  }
  return results;
}

Json[string] removeScalars(Json[string] items, string[] keys) {
  Json[string] results;
  foreach (k, v; items.byKeyValue) {
    if (!v.isScalar && !(k in keys)) {
      results[k] = v;
    }
  }
  return results;
}   

Json[string] removeScalars(Json[string] items) {
  Json[string] results;
  foreach (k, v; items.byKeyValue) {
    if (!v.isScalar) {
      results[k] = v;
    }
  }
  return results;
}