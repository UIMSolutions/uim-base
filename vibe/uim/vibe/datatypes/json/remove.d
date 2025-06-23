/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.remove;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region Json[string]
Json[string] removeAll(Json[string] map) {
  map.keys.each!(key => map.remove(key));
  return map;
}

Json[string] remove(Json[string] map, string[] keys) {
  keys.each!(key => map.remove(key));
  return map;
}

Json[string] remove(Json[string] map, string key) {
  if (map is null) {
    return map;
  }

  if (key in map) {
    map.remove(key);
  }
  return map;
}
// #endregion Json[string]

// #region Json[]
Json[] removeAll(Json[] list) {
  list = [];
  return list;
}

Json[] remove(Json[] list, size_t[] indices) {
  indices.sort!("b>a").each!(index => list.remove(index));
  return list;
}

Json[] remove(Json[] list, size_t index) {
  if (list.length == 0) {
    return list;
  }

  if (list.length > index) {
    list.remove(index);
  }
  return list;
}
// #endregion Json[]


// #region Json
Json removeAll(Json json) {
  if (json.isObject) {
    json = Json.emptyObject;
  }
  else if (json.isArray) {
    json = Json.emptyArray;
  }
  else {
    json = Json(null);
  }

  return json;
}

Json remove(Json json, string[] keys) {
  keys.each!(k => json.remove(k));
  return json;
}

Json remove(Json json, string key) {
  if (!json.isObject) {
    return json;
  }

  json.remove(key);
  return json;
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.hasKey("a"));
  json.remove("a");
  assert(!json.hasKey("a"));

  json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(!json.hasKey("x"));
  json.remove("x");
  assert(!json.hasKey("x"));
  json.remove("x");
  assert(json.hasKey("a"));
}
// #endregion Json
