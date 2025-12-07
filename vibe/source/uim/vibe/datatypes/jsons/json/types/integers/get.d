/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.integers.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
int getInteger(Json json, size_t index, int defaultValue = 0) {
  return json.isInteger(index) ? json[index].getInteger(defaultValue) : defaultValue;
}

int getInteger(Json json, string key, int defaultValue = 0) {
  return json.isInteger(key) ? json[key].getInteger(defaultValue) : defaultValue;
}

int getInteger(Json json, int defaultValue = 0) {
  return json.isInteger ? json.get!(int) : defaultValue;
}
// #endregion get