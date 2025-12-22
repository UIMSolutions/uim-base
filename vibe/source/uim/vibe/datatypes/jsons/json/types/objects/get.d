/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.objects.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[string] getObjectByIndex(Json json, size_t index, Json[string] defaultValue = null) {
  return json.isObject(index) ? json[index].getObject(defaultValue) : defaultValue;
}

Json[string] getObjectByKey(Json json, string key, Json[string] defaultValue = null) {
  return json.isObject(key) ? json[key].getObject(defaultValue) : defaultValue;
}

Json[string] getObject(Json json) {
  return json.isObject
    ? json.get!(Json[string]) : null;
}
