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
Json[] filterHasAllKey(Json[] items, string[] keys) {
  return items.filterObjects.filter!(item => item.hasKey(keys)).array;
}

Json[] filterHasAnyKey(Json[] items, string[] keys) {
  return items.filterObjects.filter!(item => item.hasAnyKey(keys)).array;
}

Json[] filterHasKey(Json[] items, string key) {
  return items.filterObjects.filter!(item => item.hasKey(key)).array;
}
// #endregion has

Json[] filterValues(Json[] items) {
  return items.filter!(item => !item.isArray & !item.isObject)
    .filter!(item => !item.isNull).array;
}

// #region objects
Json[] filterObjects(Json[] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterObjects.filter!(json => filterFunc(json)).array;
}

Json[] filterObjects(Json[] items, size_t[] indices) {
  return items.filterIndices(indices).filterObjects.array;
}

Json[] filterObjects(Json[] items) {
  return items.filter!(item => item.isObject).array;
}
// #endregion objects

// #region arrays
Json[] filterArrays(Json[] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterArrays.filter!(json => filterFunc(json)).array;
}

Json[] filterArrays(Json[] items, size_t[] indices) {
  return items.filterIndices(indices).filterArrays.array;
}

Json[] filterArrays(Json[] items) {
  return items.filter!(item => item.isArray).array;
}
// #endregion arrays

// #region booleans
Json[] filterBooleans(Json[] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterBoolean.filter!(json => filterFunc(json)).array;
}

Json[] filterBooleans(Json[] items, size_t[] indices) {
  return items.filterIndices(indices).filterBooleans.array;
}

Json[] filterBooleans(Json[] items) {
  return items.filter!(item => item.isBoolean).array;
}
// #endregion booleans

// #region integers
Json[] filterIntegers(Json[] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterBoolean.filter!(json => filterFunc(json)).array;
}

Json[] filterIntegers(Json[] items, size_t[] indices) {
  return items.filterIndices(indices).filterIntegers.array;
}

Json[] filterIntegers(Json[] items) {
  return items.filter!(item => item.isInteger).array;
}
// #endregion integers

// #region doubles
Json[] filterDoubles(Json[] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterBoolean.filter!(json => filterFunc(json)).array;
}

Json[] filterDoubles(Json[] items, size_t[] indices) {
  return items.filterIndices(indices).filterDoubles.array;
}

Json[] filterDoubles(Json[] items) {
  return items.filter!(item => item.isDouble).array;
}
// #endregion doubles

// #region strings
Json[] filterStrings(Json[] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterBoolean.filter!(json => filterFunc(json)).array;
}

Json[] filterStrings(Json[] items, size_t[] indices) {
  return items.filterIndices(indices).filterStrings.array;
}

Json[] filterStrings(Json[] items) {
  return items.filter!(item => item.isString).array;
}
// #endregion strings

Json[] filterIndices(Json[] items, size_t[] indices) {
  return indices.filter!(index => items.length > index).map!(index => items[index]).array;
}
