/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.objects.has;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

// #region value
// #region hasAllValues
bool hasAllValues(T)(Json json, T[] values, bool deepSearch = false) {
  return values.all!(value => hasValue(json, value, deepSearch));
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}], "i": "j"}`);
  assert(json.hasAllValues([Json("b"), Json("j")]));
  // assert(json.hasAllValues([Json("h"), Json(1)], true));
}
// #endregion hasAllValues

// #region hasAnyValues
// Search if json has any of the values
bool hasAnyValue(T)(Json json, T[] values, bool deepSearch = false) {
  return values.any!(value => hasValue(json, value, deepSearch));
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}], "i": "j"}`);
  assert(json.hasAllValues([Json("b"), Json("j")]));
  // assert(json.hasAllValues([Json("h"), Json(1)], true));
}
// #endregion hasAnyValues

// #region hasValue
// Search if jsonData has value
bool hasValue(T)(Json json, T value, bool deepSearch = false) {
  return hasValue(json, value.toJson, deepSearch);
}

bool hasValue(T:Json)(Json json, T value, bool deepSearch = false) {
  if (json.isObject) {
    foreach (kv; json.byKeyValue) {
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
    if (json.isArray) {
      for (size_t i = 0; i < json.length; i++) {
        const result = json[i].hasValue(value);
        if (result) {
          return true;
        }
      }
    }
  }

  return false;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.hasValue(Json("b")));
  // assert(json.hasValue(Json("h"), true));
  assert(!json.hasValue(Json("x")));
  // assert(!json.hasValue(Json("y"), true));
}
// #endregion hasValue
// #endregion value


