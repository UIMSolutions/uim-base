/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region has
Json[] filterHasAllKey(Json[] jsons, string[] keys) {
  return jsons.filterObjects.filter!(item => item.hasKey(keys)).array;
}

Json[] filterHasAnyKey(Json[] jsons, string[] keys) {
  return jsons.filterObjects.filter!(item => item.hasAnyKey(keys)).array;
}

Json[] filterHasKey(Json[] jsons, string key) {
  return jsons.filterObjects.filter!(item => item.hasKey(key)).array;
}
// #endregion has

Json[] filterValues(Json[] jsons) {
  return jsons.filter!(item => !item.isArray & !item.isObject)
    .filter!(item => !item.isNull).array;
}

// #region objects
Json[] filterObjects(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterObjects.filter!(json => filterFunc(json)).array;
}

Json[] filterObjects(Json[] jsons, size_t[] indices) {
  return jsons.filterIndices(indices).filterObjects.array;
}

Json[] filterObjects(Json[] jsons) {
  return jsons.filter!(item => item.isObject).array;
}
// #endregion objects

// #region arrays
Json[] filterArrays(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterArrays.filter!(json => filterFunc(json)).array;
}

Json[] filterArrays(Json[] jsons, size_t[] indices) {
  return jsons.filterIndices(indices).filterArrays.array;
}

Json[] filterArrays(Json[] jsons) {
  return jsons.filter!(json => json.isArray).array;
}
// #endregion arrays

// #region indices
Json[] filterIndices(Json[] jsons, size_t[] indices) {
  return indices.filter!(index => jsons.length > index).map!(index => jsons[index]).array;
}
// #region endindices
