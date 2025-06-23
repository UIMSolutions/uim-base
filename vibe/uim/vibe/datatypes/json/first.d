/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.first;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region Json[]
Json firstObject(Json[] items) {
  return items.filterObject.first;
}

Json firstNotObject(Json[] items) {
  return items.filterNotObject.first;
}

Json firstHasKey(Json[] items, string key) {
  return items.filterHasKey(key).first;
}

Json firstWithoutKey(Json[] items, string key) {
  return items.filterWithoutKey(key).first;
}
// #endregion Json[]

// #region Json
Json firstObject(Json json) {
  return json.isArray
    ? json.toArray.filterObject.first : Null!Json;
}

Json firstNotObject(Json json) {
  return json.isArray
    ? json.toArray.filterNotObject.first : Null!Json;
}

Json firstHasKey(Json json, string key) {
  return json.isArray
    ? json.toArray.filterHasKey(key).first : Null!Json;
}

Json firstWithoutKey(Json json, string key) {
  return json.isArray
    ? json.toArray.filterWithoutKey(key).first : Null!Json;
}
// #endregion Json
