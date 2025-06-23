/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.values;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region values
// Get values from json object
Json[] values(Json json, string[] keys) {
  return json.isObject
    ? keys
    .filter!(key => json.hasKey(key))
    .map!(key => json[key])
    .array : null;
}

unittest {
  auto json = parseJsonString(`{"a": "A", "b": "B", "c": "C"}`);

  /*   assert(json.hasAllValues(Json("A"), Json("B"), Json("C")));
  assert(json.hasAllValues([Json("A"), Json("B"), Json("C")]));
  assert(!json.hasAllValues([Json("A"), Json("B"), Json("D")])); */
}
// #endregion values

