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

Json[] filterScalars(Json jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterScalars;
}

Json[] filterScalars(Json json) {
  return json.isArray || json.isObject
    ? json.values.filter!(item => item.isScalar).array : null;
}
