/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.integers.filter;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[string]
Json[string] filterIntegers(Json[string] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterIntegers.filter!(json => filterFunc(json)).array;
}

Json[string] filterIntegers(Json[string] items, string[] keys) {
  return items.filterKeys(keys).filter!(json => json.isInteger).array;
}

Json[string] filterIntegers(Json[string] items) {
  return items.byValue.array.filter!(json => json.isInteger).array;
}
// #endregion Json[string]

// #region Json
Json[] filterIntegers(Json json, bool delegate(Json json) @safe filterFunc) {
  return json.filterIntegers.filter!(j => filterFunc(j)).array;
}

/* 
Json[] filterIntegers(Json jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterArray.array;
}
*/

Json filterIntegers(Json json) {
  if (json.isArray) {
    return json.toArray.filterIntegers.toJson;
  }

  /* 
  if (json.isObject) {
    return json.byValue.filterIntegers!(item => item.isArray).array;
  }
  */ 

  return null;
}
// #endregion Json
