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
  import uim.vibe.datatypes.jsons.arrays.types.objects.filter;

  return jsons.filterObjects.first;
}

Json firstObjectWithAllKey(Json[] jsons, string[] keys) {
  import uim.vibe.datatypes.jsons.arrays.types.objects.filter;

  return jsons.filterObjectsWithAllKey(keys).first;
}

Json firstObjectWithAnyKey(Json[] jsons, string[] keys) {
  import uim.vibe.datatypes.jsons.arrays.types.objects.filter;

  return jsons.filterObjectsWithAnyKey(keys).first;
}

Json firstObjectWithKey(Json[] jsons, string key) {
  import uim.vibe.datatypes.jsons.arrays.types.objects.filter;

  return jsons.filterObjectsWithKey(key).first;
}

Json firstObjectWithoutKey(Json[] jsons, string key) {
  import uim.vibe.datatypes.jsons.arrays.types.objects.filter;

  return jsons.filterObjectsWithoutKey(key).first;
}
