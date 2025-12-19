/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.objects.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] filterObjects(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterObjects.filter!(json => filterFunc(json)).array;
}

Json[] filterObjects(Json[] jsons, size_t[] indices) {
  return jsons.filterIndices(indices).filterObjects.array;
}

Json[] filterObjects(Json[] jsons) {
  return jsons.filter!(json => json.isObject).array;
}

Json[] filterObjectsWithAllKey(Json[] jsons, string[] keys) {
  return jsons.filterObjects.filter!(json => json.hasAllKey(keys)).array;
}

Json[] filterObjectsWithAnyKey(Json[] jsons, string[] keys) {
  return jsons.filterObjects.filter!(json => json.hasAnyKey(keys)).array;
}

Json[] filterObjectsWithKey(Json[] jsons, string key) {
  return jsons.filterObjects.filter!(json => json.hasKey(key)).array;
}

Json[] filterObjectsWithoutKey(Json[] jsons, string key) {
  return jsons.filterObjects.filter!(json => !json.hasKey(key)).array;
}
