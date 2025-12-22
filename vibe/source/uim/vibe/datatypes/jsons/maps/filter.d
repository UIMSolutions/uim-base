/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.maps.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region keys
Json[string] filterKeys(Json[string] items, string[] keys) {
  return keys.filter!(key => key in items).map!(key => items[key]).array;
}
// #region keys

// #region Objects
Json[string] filterObjects(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterObjects.filter!(json => filterFunc(json)).array;
}

Json[] filterObjects(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isObject).array;
}

Json[string] filterObjects(Json[string] items) {
  return items.byValue.array.filter!(json => json.isObject).array;
}
// #endregion Objects

// #region Scalars
Json[] filterScalars(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterScalars.filter!(json => filterFunc(json)).array;
}

Json[] filterScalars(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isScalar).array;
}

Json[] filterScalars(Json[string] items) {
  return items.byValue.array.filter!(json => json.isScalar).array;
}
// #endregion Scalars

