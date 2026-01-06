/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject get the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.get;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[string]
Json getValue(Json[string] map, string[] path) {
  if (map.isNull || path.length == 0) {
    return Json(null);
  }

  auto key = path[0];
  if (!(key in map)) {
    return Json(null);
  }

  auto value = map[key];
  if (value == Json(null) || path.length == 1) {
    return value;
  }

  return  value.isObject && path.length > 1 ? value.getValue(path[1 .. $]) : Json(null);
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getValue with path");

  // Test with null map
  Json[string] nullMap;
  assert(nullMap.getValue(["key"]) == Json(null));

  // Test with empty path
  Json[string] map = ["key": "value".toJson];
  string[] emptyPath;
  assert(map.getValue(emptyPath) == Json(null));

  // Test with non-existent key in path
  assert(map.getValue(["nonexistent"]) == Json(null));

  // Test with single element path
  Json[string] map2 = ["data": "value".toJson];
  assert(map2.getValue(["data"]) == "value".toJson);

  // Test with nested path - successful
  Json[string] map3 = ["data": ["test": "nested".toJson].toJson];
  assert(map3.getValue(["data", "test"]) == "nested".toJson);

  // Test with nested path - null value
  Json[string] map4 = ["data": Json(null)];
  assert(map4.getValue(["data", "test"]) == Json(null));

  // Test with path longer than structure
  Json[string] map5 = ["data": ["test": "value".toJson].toJson];
  assert(map5.getValue(["data", "test", "extra"]) == Json(null));

  // Test with non-object intermediate value
  Json[string] map6 = ["data": "string".toJson];
  assert(map6.getValue(["data", "test"]) == Json(null));

  // Test with array values
  Json[string] map7 = ["data": ["test": [1, 2, 3].toJson].toJson];
  assert(map7.getValue(["data", "test"]) == [1, 2, 3].toJson);

  // Test with multiple nested levels
  Json[string] map8 = ["a": ["b": ["c": "deep".toJson].toJson].toJson];
  assert(map8.getValue(["a", "b", "c"]) == "deep".toJson);

  Json getValue(Json[string] map, string key) {
    return key in map ? map[key] : Json(null);
  }
}

Json getValue(Json[string] map, string key) {
  return key in map ? map[key] : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getValue with key");

  Json[string] map = ["key1": "value1".toJson, "key2": "value2".toJson];
  assert(map.getValue("key2") == "value2".toJson);
}
// #endregion Json[string]

// #region Json
Json getValue(Json json, size_t index) {
  if (!json.isArray) {
    return Json(null);
  }
  return json.length > index ? json[index] : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getValue with index");

  Json json = [1, 2, 3].toJson;
  assert(json.getValue(1) == 2.toJson);
}

Json getValue(Json json, string[] path) {
  if (json == Json(null) || path.length == 0) {
    return Json(null);
  }

  // writeln("Checking isArray for path: ", path, " in json: ", json, " of type ", json.type);
  auto firstJson = json.getValue(path[0]);
  if (path.length == 1 || firstJson == Json(null)) {
    return firstJson;
  }

  // writeln("Checking isArray for path[0]: ", path[0], " in firstJson: ", firstJson, " of type ", firstJson.type);
  return path.length > 1 ? firstJson.getValue(
    path[1 .. $]) : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getValue with path");

  Json json = parseJsonString(`{"data": { "test": [1, 2, 3]}}`);
  assert(json.getValue(["data"]).getValue(["test"]) != Json(null));
  assert(json.getValue(["data", "test"]) != Json(null));
  assert(json.getValue(["data", "test"]) == [1, 2, 3].toJson);
}

Json getValue(Json json, string key) {
  if (!json.isObject) {
    return Json(null);
  }

  return key in json ? json[key] : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getValue with key");

  Json json = ["key1": "value1".toJson, "key2": "value2".toJson].toJson;
  assert(json.getValue("key2") == "value2".toJson);
}
// #endregion Json
