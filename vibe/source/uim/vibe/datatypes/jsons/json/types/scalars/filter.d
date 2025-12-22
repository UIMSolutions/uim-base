/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.scalars.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] filterScalars(Json json, bool delegate(Json json) @safe filterFunc) {
  return json.filterScalars.filter!(j => filterFunc(j)).array;
}

/* 
Json[] filterScalars(Json jsons, size_t[] indices) {
  return jsons.filterIndices(indices).filterArray.array;
}
*/

Json[] filterScalars(Json json) {
  if (json.isArray) {
    return json.toArray.filter!(item => item.isArray).array;
  }
  if (json.isObject) {
    return json.byValue.filter!(item => item.isArray).array;
  }
  return json.isArray ? [json] : null;
}