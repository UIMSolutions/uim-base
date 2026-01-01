/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.maps.types.booleans.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json[string] filterBooleans(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterArrays.filter!(json => filterFunc(json)).array;
}

Json[string] filterBooleans(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isBoolean).array;
}

Json[string] filterBooleans(Json[string] items) {
  return items.byValue.array.filter!(json => json.isBoolean).array;
}
