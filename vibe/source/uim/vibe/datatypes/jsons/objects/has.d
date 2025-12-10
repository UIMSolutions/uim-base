/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.objects.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region value
// #region hasAllValue
bool hasAllValue(T)(Json json, T[] values, bool deepSearch = false) {
  return values.all!(value => hasValue(json, value, deepSearch));
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}], "i": "j"}`);
  assert(json.hasAllValue([Json("b"), Json("j")]));
  // assert(json.hasAllValue([Json("h"), Json(1)], true));
}
// #endregion hasAllValue

// #region hasAnyValue
// Search if json has any of the values
bool hasAnyValue(T)(Json json, T[] values, bool deepSearch = false) {
  return values.any!(value => hasValue(json, value, deepSearch));
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}], "i": "j"}`);
  assert(json.hasAllValue([Json("b"), Json("j")]));
  // assert(json.hasAllValue([Json("h"), Json(1)], true));
}
// #endregion hasAnyValue

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

// #region key
// #region hasAllKey
bool hasAllKey(Json[string] items, string[] keys) {
  return keys.all!(key => hasKey(items, key));
}
// #endregion hasAllKey

// #region hasAnyKey
bool hasAnyKey(Json[string] items, string[] keys) {
  return keys.any!(key => hasKey(items, key));
}
// #endregion hasAnyKey

// #region hasKey
bool hasKey(Json[string] items, string key) {
  return key in items ? true : false;
}
// #endregion hasKey
// #endregion key
