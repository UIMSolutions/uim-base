/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject get the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.get;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[string]
Json getValue(Json[string] map, string[] path) {
  if (!map.isNull || path.length == 0) {
    return Json(null);
  }

  auto json = map.getValue(path[0]);
  if (path.length == 1 || json == Json(null)) {
    return json;
  }

  return json.isObject ? json.getValue(path[1 .. $]) : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getValue with path");

  Json[string] map = ["data": ["test": [1, 2].toJson].toJson];
  assert(map.getValue(["data", "test"]) == [1, 2].toJson);
}

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

  auto firstJson = json.getValue(path[0]);
  if (path.length == 1) {
    return firstJson;
  }

  return !firstJson == Json(null) && path.length > 1 ? json.getValue(
    path[1 .. $]) : Json(null);
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getValue with path");

  Json json = parseJsonString(`{"data": { "test": [1, 2, 3]}}`);
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
