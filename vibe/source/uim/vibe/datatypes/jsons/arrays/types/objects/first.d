/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.objects.first;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json firstObject(Json[] jsons) {
  return jsons.filterObjects.first;
}

Json firstObjectWithAllKey(Json[] jsons, string[] keys) {
  return jsons.filterObjectsWithAllKey(keys).first;
}

Json firstObjectWithAnyKey(Json[] jsons, string[] keys) {
  return jsons.filterObjectsWithAnyKey(keys).first;
}

Json firstObjectWithKey(Json[] jsons, string key) {
    return jsons.filterObjectsWithKey(key).first;
}

Json firstObjectWithoutKey(Json[] jsons, string key) {
    return jsons.filterObjectsWithoutKey(key).first;
}


