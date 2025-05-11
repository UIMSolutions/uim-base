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

// #region set
Json[string] setValues(Json[string] map, Json[string] values) {
  foreach(kv; values.byKeyValue) {
    map = map.setValue(kv.key, kv.value);
  }
  return map;
}

Json[string] setValues(Json[string] map, string[] keys, Json value) {
  keys.each!(key => map = map.setValue(key, value));
  return map;
}

Json[string] setValue(Json[string] map, string key, Json value) {
  map[key] = value;
  return map;
}

Json setValues(Json json, Json[string] map) {
  foreach(kv; map.byKeyValue) {
    json = json.setValue(kv.key, kv.value);
  }
  return json;
}

Json setValues(Json json, string[] keys, Json value) {
  keys.each!(key => json = json.setValue(key, value));
  return json;
}

Json setValue(Json json, string[] path, Json value) {
  if (path.length == 0) {
    return json;
  }

  if (path.length == 1) {
    return json.setValue(path[0], value);
  }

  auto key = path[0];
  if (key !in json) {
    json[key] = Json.emptyObject;
  }

  json[key] = json[key].setValue(path[1..$], value);
  return json;
}

Json setValue(Json json, string key, Json value) {
  if (json.isObject) {
    json[key] = value;
  }
  return json;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.setValue("a", Json("A"))["a"] == Json("A"));
  assert(json.setValues(["a", "b"], Json("B"))["a"] == Json("B"));
  assert(json.setValues(["a", "b"], Json("B"))["b"] == Json("B"));
  assert(json.setValues(["a", "b"], Json("B"))["c"] == Json("C"));
}
// #endregion set

// #region merge
Json[string] mergeValue(Json[string] map, string key, Json value) {
  if (key !in map) {
    map[key] = value;
  }
  return map;
}

Json mergeValue(Json json, string key, Json value) {
  if (json.isObject && key !in json) {
    json[key] = value;
  }
  return json;
}

unittest {
  auto json = Json.emptyObject;
  assert(json.mergeValue("a", Json("A"))["a"] == Json("A"));
  assert(json.mergeValue("b", Json("B"))["b"] == Json("B"));
  assert(json.mergeValue("c", Json("C"))["c"] == Json("C"));
}
// #region merge
