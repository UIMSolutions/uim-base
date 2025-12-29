/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.booleans.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool getBooleanByIndex(Json json, size_t index, bool defaultValue = false) {
  return json.isBoolean(index) ? json[index].getBoolean(defaultValue) : defaultValue;
}

bool getBooleanByKey(Json json, string key, bool defaultValue = false) {
  return json.isBoolean(key) ? json[key].getBoolean(defaultValue) : defaultValue;
}

bool getBoolean(Json json, bool defaultValue = false) {
  return json.isBoolean
    ? json.get!(bool) : defaultValue;
}
