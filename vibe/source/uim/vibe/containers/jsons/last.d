/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.containers.jsons.last;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json last(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.last.last(json.toArray) : Json(null);
}

Json lastObject(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.last.last(json.toArray.filterObjects) : Json(null);
}

Json lastArray(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.last.last(json.toArray.filterArrays) : Json(null);
}

Json lastValue(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.last.last(json.toArray.filterValues) : Json(null);
}

Json lastHasAllKey(Json json, string[] keys) {
  return json.isArray
    ? uim.phobos.containers.arrays.last.last(json.toArray.filterHasAllKey(keys)) : Json(null);
}

Json lastHasAnyKey(Json json, string[] keys) {
  return json.isArray
    ? uim.phobos.containers.arrays.last.last(json.toArray.filterHasAnyKey(keys)) : Json(null);
}

Json lastHasKey(Json json, string key) {
  return json.isArray
    ? uim.phobos.containers.arrays.last.last(json.toArray.filterHasKey(key)) : Json(null);
}
