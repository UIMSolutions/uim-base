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

  writeln("Checking if path[0] is null: ", path[0]);
  if (map.isNull(path[0])) {
    return Json(null);
  }

  writeln("Getting value for path: ", path);
  auto json = map.getValue(path[0]);
  if (path.length == 1) {
    return json;
  }

  return json.isObject ? json.getValue(path[1 .. $]) : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getValue with path");

  Json[string] map = ["data": ["test": [1, 2].toJson].toJson];
  writeln(map.getValue(["data"]));
  writeln(map.getValue(["data", "test"]));
  assert(map.getValue(["data", "test"]) == [1, 2].toJson);
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
  writeln(`json.getValue("data") -> `, json.getValue("data"));
  writeln(`json.getValue(["data"]) -> `, json.getValue(["data"]));

  writeln(`json.getValue("data").getValue("test") -> `, json.getValue("data").getValue("test"));
  writeln(`json.getValue(["data", "test"]) -> `, json.getValue(["data", "test"]));

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
