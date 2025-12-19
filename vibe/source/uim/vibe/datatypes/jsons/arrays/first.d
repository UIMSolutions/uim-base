/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.first;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json firstObject(Json[] jsons) {
  return jsons.filterObjects.first;
}

Json firstArray(Json[] jsons) {
  return jsons.filterArrays.first;
}

Json firstScalar(Json[] jsons) {
  return jsons.filterScalars.first;
}

Json firstWithAllKey(Json[] jsons, string[] keys) {
  return jsons.filterObjectWithAllKey(keys).first;
}

Json firstHWithAnyKey(Json[] jsons, string[] keys) {
  return jsons.filterObjectWithAnyKey(keys).first;
}

Json firstWithKey(Json[] jsons, string key) {
  return jsons.filterObjectWithKey(key).first;
}

Json first(Json[] jsons) {
  return jsons.length > 0 ? jsons[0] : Json(null);
}
