/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.integers.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region func
/**
  * Filters the given Json array of integers based on a provided filter function.
  *
  * Params:
  *   jsons = The Json array to filter.
  *   filterFunc = A delegate function that takes a Json and returns a bool indicating whether to include it.
  *
  * Returns:
  *   A new Json array containing only the integers that satisfy the filter function.
  */
Json[] filterIntegers(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterIntegers.filter!(json => filterFunc(json)).array;
}
// #endregion func

// #region indices
/** 
  * Filters the given Json array to include only integers at the specified indices.
  *
  * Params:
  *   jsons = The Json array to filter.
  *   indices = The indices of the Json array to consider for filtering.
  *
  * Returns:
  *   A new Json array containing only the integers at the specified indices.
  */
Json[] filterIntegers(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterIntegers.array;
}
// #endregion indices

// #region filter
/** 
  * Filters the given Json array to include only integer values.
  *
  * Params:
  *   jsons = The Json array to filter.
  *
  * Returns:
  *   A new Json array containing only the integer values.
  */
Json[] filterIntegers(Json[] jsons) {
  return jsons.filter!(item => item.isInteger).array;
}
// #endregion filter
