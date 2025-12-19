/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.objects.last;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json lastObject(Json[] jsons) {
  return jsons.filterObjects.last;
}

Json lastObjectWithAllKey(Json[] jsons, string[] keys) {
  return jsons.filterObjectsWithAllKey(keys).last;
}

Json lastObjectWithAnyKey(Json[] jsons, string[] keys) {
  return jsons.filterObjectsWithAnyKey(keys).last;
}

Json lastObjectWithKey(Json[] jsons, string key) {
    return jsons.filterObjectsWithKey(key).last;
}

Json lastObjectWithoutKey(Json[] jsons, string key) {
    return jsons.filterObjectsWithoutKey(key).last;
}


