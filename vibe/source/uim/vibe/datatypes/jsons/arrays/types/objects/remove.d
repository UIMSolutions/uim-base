/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.objects.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/**
  Removes objects from the provided Json array based on a delegate function.
  
  Params:
    jsons = The Json array to process.
    removeFunc = A delegate function that determines whether to remove an object.
  
  Returns:
    A new Json array with the specified objects removed.
  */
Json[] removeObjects(Json[] jsons, bool delegate(Json json) removeFunc) {
  return jsons.filter!(json => !foundObject(json, removeFunc)).array;
}

Json[] removeObjects(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices).removeObjects.array;
}

Json[] removeObjects(Json[] jsons) {
  return jsons.filter!(json => !json.isObject).array;
}

Json[] removeObjectsWithAllKey(Json[] jsons, string[] keys) {
  return jsons.filter!(json => !json.hasAllKey(keys)).array;
}

Json[] removeObjectsWithAnyKey(Json[] jsons, string[] keys) {
  return jsons.filter!(json => !json.hasAnyKey(keys)).array;
}

Json[] removeObjectsWithKey(Json[] jsons, string key) {
  return jsons.filter!(json => !json.hasKey(key)).array;
}

Json[] removeObjectsWithKeyValue(Json[] jsons, string key, Json value) {
  return jsons.filter!(json => !json.hasKeyValue(key, value)).array;
}

protected bool foundObject(Json json, bool delegate(Json value) removeFunc) {
  bool found = false;
  () @trusted { found = json.isObject && json.removeFunc; }();
  return found;
}
