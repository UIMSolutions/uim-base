/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.integers.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[string]
Json[string] filterIntegers(Json[string] items, bool delegate(string key, Json value) @safe filterFunc) {
  Json[string] results;
  items.byKeyValue.each!((kv) => {
    if (filterFunc(kv.key, kv.value) && kv.value.isInteger) {
      results[kv.key] = kv.value;
    }
  });
  return results;
}

Json[string] filterIntegers(Json[string] items, string[] keys) {
  Json[string] results;
  items.byKeyValue.each!((kv) => {
    if (keys.hasValue(kv.key) && kv.value.isInteger) {
      results[kv.key] = kv.value;
    }
  });
  return results;
}

Json[string] filterIntegers(Json[string] items) {
  Json[string] results;
  items.byKeyValue.each!((kv) => {
    if (kv.value.isInteger) {
      results[kv.key] = kv.value;
    }
  });
  return results;
}
// #endregion Json[string]

// #region Json[]
Json[] filterIntegers(Json[] items, bool delegate(Json json) @safe filterFunc) {
  return items.filterIntegers.filter!(json => filterFunc(json)).array;
}

Json[] filterIntegers(Json[] items, size_t[] indices) {
  return items.filterValue(indices).filterIntegers;
}

Json[] filterIntegers(Json[] items) {
  return items.filter!(json => json.isInteger).array;
}
// #endregion Json[strng]

// #region Json
Json[] filterIntegers(Json json, bool delegate(Json json) @safe filterFunc) {
  return json.filterIntegers.toArray.filter!(j => filterFunc(j)).array;
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

  return Json(null);
}
// #endregion Json
