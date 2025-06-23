/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.has;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

bool hasAllValues(Json json, Json[] values, bool deepSearch = false) {
  foreach (value; values)
    if (!hasValue(json, value)) {
      return false;
    }
  return true;
}
///

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}], "i": "j"}`);
  assert(json.hasAllValues([Json("b"), Json("j")]));
  // assert(json.hasAllValues([Json("h"), Json(1)], true));
}

// Search if jsonData has any of the values
bool hasAnyValue(Json jsonData, Json[] values, bool deepSearch = false) {
  return values.any!(value => hasValue(jsonData, value));
}
///

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}], "i": "j"}`);
  assert(json.hasAllValues([Json("b"), Json("j")]));
  // assert(json.hasAllValues([Json("h"), Json(1)], true));
}

// Search if jsonData has value
bool hasValue(Json jsonData, Json value, bool deepSearch = false) {
  if (jsonData.isObject) {
    foreach (kv; jsonData.byKeyValue) {
      if (kv.value == value) {
        return true;
      }
      if (deepSearch) {
        auto result = kv.value.hasValue(value);
        if (result) {
          return true;
        }
      }
    }
  }

  if (deepSearch) {
    if (jsonData.isArray) {
      for (size_t i = 0; i < jsonData.length; i++) {
        const result = jsonData[i].hasValue(value);
        if (result) {
          return true;
        }
      }
    }
  }

  return false;
}
///
unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.hasValue(Json("b")));
  // assert(json.hasValue(Json("h"), true));
  assert(!json.hasValue(Json("x")));
  // assert(!json.hasValue(Json("y"), true));
}


