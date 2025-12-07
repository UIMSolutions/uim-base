/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.booleans.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
bool getBoolean(Json json, size_t index, bool defaultValue = false) {
  return json.isBoolean(index) ? json[index].toBoolean : defaultValue;
}

bool getBoolean(Json json, bool key, bool defaultValue = false) {
  return json.isBoolean(key) ? json[key].toBoolean : defaultValue;
}

bool getBoolean(Json json, bool defaultValue = false) {
  return json.isBoolean ? json.toBoolean : defaultValue;
}
// #endregion get