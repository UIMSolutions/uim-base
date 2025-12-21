/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.objects.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] removeObjects(Json[] jsons, bool delegate(Json json) removeFunc) {
  return jsons.filter!(json => !foundObject(json, removeFunc)).array;
}

Json[] removeObjects(Json[] jsons, size_t[] indices) {
  return jsons.removeIndices(indices).removeObjects.array;
}

Json[] removeObjects(Json[] jsons) {
  return jsons.filter!(json => !json.isObject).array;
}

Json[] removeObjectsWithKey(Json[] jsons, string[] keys) {
  return keys.map!(key => removeObjectsWithKey(key)).array;
}

Json[] removeObjectsWithKey(Json[] jsons, string key) {
  return jsons.removeObjects.remove!(json => json.hasKey(key)).array;
}

Json[] removeObjectsWithKeyValue(Json[] jsons, string key, Json value) {
  return jsons.removeObjects.remove!(json => json.hasKeyValue(key, value)).array;
}

protected bool foundObject(Json json, bool delegate(Json value) removeFunc) {
  bool found = false;
  () @trusted { found = json.isObject && json.removeFunc; }();
  return found;
}