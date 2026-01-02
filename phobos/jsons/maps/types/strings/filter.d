/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.maps.types.strings.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json[string] filterStrings(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterStrings.filter!(json => filterFunc(json)).array;
}

Json[string] filterStrings(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isString).array;
}

Json[string] filterStrings(Json[string] items) {
  Json[string] results;
  foreach (k, v; items.byKeyValue) {
    if (v.isString) {
      results[k] = v;
    }
  }
  return results;
}

protected bool foundFilterString(Json json, bool delegate(Json value) @safe filterFunc) {
  return json.isString && filterFunc(json);
}
