/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.arrays.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json filterArrays(Json json, bool delegate(Json json) @safe filterFunc) {
  if (json.isArray) {
    return json.filterValues((Json item) => item.isArray).toJson;
  }
  /* 
  if (json.isObject) {
    return json.toMap.filterArrays!(item => item.isArray).toJson;
  }
  */
  return Json(null);
}

/* 
Json[] filterArrays(Json jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterArray.array;
}
*/

Json filterArrays(Json json) {
  if (json.isArray) {
    return json.toArray.filter!(item => item.isArray).array.toJson;
  }
  /* 
  if (json.isObject) {
    return json.toMap.filterArrays(item => item.isArray).array.toJson;
  }
  */
  return Json(null);
}
