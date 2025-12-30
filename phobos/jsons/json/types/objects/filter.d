/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.objects.filter;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[] filterObjects(Json json, bool delegate(Json json) @safe filterFunc) {
  return json.filterObjects.filter!(j => filterFunc(j)).array;
}

/* 
Json[] filterObjects(Json jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterArray.array;
}
*/

Json[] filterObjects(Json json) {
  if (json.isArray || json.isObject) {
    return json.values.filter!(item => item.isObject).array;
  }
  return json.isObject ? [json] : null;
}