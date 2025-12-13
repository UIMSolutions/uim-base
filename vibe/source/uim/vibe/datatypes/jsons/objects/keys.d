/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.objects.keys;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

// #region keys
// Get keys from json object
string[] keys(Json json, bool sorted = false) {
  return json.isObject
    ? json.convert((string key) => key) : null;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.keys.hasAll(["a", "c", "e"]));
  assert(!json.keys.hasAll(["a", "c", "x"]));
}
// #endregion keys

// #region hasSearch
