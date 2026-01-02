/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.objects.last;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json lastObject(Json[] jsons) {
  import uim.root.datatypes.jsons.arrays.types.objects.filter;

  return jsons.filterObjects.last;
}

Json lastObjectWithAllKey(Json[] jsons, string[] keys) {
  import uim.root.datatypes.jsons.arrays.types.objects.filter;

  return jsons.filterObjectsWithAllKey(keys).last;
}

Json lastObjectWithAnyKey(Json[] jsons, string[] keys) {
  import uim.root.datatypes.jsons.arrays.types.objects.filter;

  return jsons.filterObjectsWithAnyKey(keys).last;
}

Json lastObjectWithKey(Json[] jsons, string key) {
  import uim.root.datatypes.jsons.arrays.types.objects.filter;

  return jsons.filterObjectsWithKey(key).last;
}

Json lastObjectWithoutKey(Json[] jsons, string key) {
  import uim.root.datatypes.jsons.arrays.types.objects.filter;

  return jsons.filterObjectsWithoutKey(key).last;
}
