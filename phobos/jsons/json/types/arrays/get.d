/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.arrays.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[] getArrayByIndex(Json json, size_t index, Json[] defaultValue = null) {
  return isArray(json, index) ? json[index].getArray(defaultValue) : defaultValue;
}

Json[] getArrayByKey(Json json, string key, Json[] defaultValue = null) {
  return isArray(json, key) ? json[key].getArray(defaultValue) : defaultValue;
}

Json[] getArray(Json json, Json[] defaultValue = null) {
  return isArray(json) ? json.get!(Json[]) : defaultValue;
}
