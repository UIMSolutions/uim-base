/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.objects.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json[] filterObjects(Json[] jsons, bool delegate(Json json) filterFunc) {
  return jsons.filterObjects.filterValues(filterFunc);
}

Json[] filterObjects(Json[] jsons, bool delegate(Json json) @safe filterFunc) {
  return jsons.filterObjects.filterValues(filterFunc);
}

Json[] filterObjects(Json[] jsons, size_t[] indices) {
  return jsons.filterValues(indices).filterObjects;
}

Json[] filterObjects(Json[] jsons) {
  return jsons.filterValues((Json json) => json.isObject);
}

Json[] filterObjectsWithAllKey(Json[] jsons, string[] keys) {
  return jsons.filterObjects.filterValues((Json json) =>json.hasAllKey(keys));
}

Json[] filterObjectsWithAnyKey(Json[] jsons, string[] keys) {
  return jsons.filterObjects.filterValues((Json json) => json.hasAnyKey(keys));
}

Json[] filterObjectsWithKey(Json[] jsons, string key) {
  return jsons.filterObjects.filterValues((Json json) => json.hasKey(key));
}

Json[] filterObjectsWithoutKey(Json[] jsons, string key) {
  return jsons.filterObjects.filterValues((Json json) => !json.hasKey(key));
}
