/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.containers.arrays.first;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

T first(Json json) {
  return json.isArray
    ? first(json.toArray) : Json(null)
}

Json firstObject(Json json) {
  return json.isArray
    ? json.toArray.filterObjects.first : Json(null);
}

Json firstArray(Json json) {
  return json.isArray
    ? json.toArray.filterArrays.first : Json(null);
}

Json firstValue(Json json) {
  return json.isArray
    ? json.toArray.filterValues.first : Json(null);
}

Json firstHasAllKeys(Json json, string[] keys) {
  return json.isArray
    ? json.toArray.filterHasAllKeys(keys).first : Json(null);
}

Json firstHasAnyKey(Json json, string[] keys) {
  return json.isArray
    ? json.toArray.filterHasAnyKey(keys).first : Json(null);
}

Json firstHasKey(Json json, string key) {
  return json.isArray
    ? json.toArray.filterHasKey(key).first : Json(null);
}