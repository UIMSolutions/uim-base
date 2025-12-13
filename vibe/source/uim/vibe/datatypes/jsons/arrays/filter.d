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
Json[] filterObjects(Json[] items) {
  return items.filter!(item => item.isObject).array;
}
// #endregion objects

// #region arrays
Json[] filterArrays(Json[] items) {
  return items.filter!(item => item.isArray).array;
}
// #endregion arrays

