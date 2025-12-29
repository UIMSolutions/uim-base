/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.last;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json last(Json json) {
  return json.isArray
    ? last(json.toArray) : Json(null);
}

Json lastObject(Json json) {
  return json.isArray
    ? last(json.toArray.filterObjects) : Json(null);
}

Json lastArray(Json json) {
  return json.isArray
    ? last(json.toArray.filterArrays) : Json(null);
}

Json lastScalar(Json json) {
  return json.isArray
    ? last(json.toArray.filterValues) : Json(null);
}

Json lastWithAllKey(Json json, string[] keys) {
  return json.isArray
    ? last(json.toArray.filterHasAllKey(keys)) : Json(null);
}

Json lastWithAnyKey(Json json, string[] keys) {
  return json.isArray
    ? last(json.toArray.filterHasAnyKey(keys)) : Json(null);
}

Json lastHasKey(Json json, string key) {
  return json.isArray
    ? last(json.toArray.filterHasKey(key)) : Json(null);
}
