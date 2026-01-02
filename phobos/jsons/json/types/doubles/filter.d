/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.doubles.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json[] filterDoubles(Json json, bool delegate(Json json) @safe filterFunc) {
  return json.filterDoubles.filter!(j => filterFunc(j)).array;
}

/* 
Json[] filterDoubles(Json jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterArray.array;
}
*/

Json[] filterDoubles(Json json) {
  if (json.isArray) {
    return json.toArray.filter!(item => item.isArray).array;
  }
  if (json.isObject) {
    return json.byValue.filter!(item => item.isArray).array;
  }
  return json.isArray ? [json] : null;
}