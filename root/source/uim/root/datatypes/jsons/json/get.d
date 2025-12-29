/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject get the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json getPath(Json[string] map, string[] path) {
  if (map is null || path.length == 0) {
    return Json(null);
  }

  auto firstJson = path[0] in map ? map[path[0]] : Json(null);
  if (path.length == 1) {
    return firstJson;
  }

  return !firstJson.isNull && path.length > 1 ? map[path[0]].getPath(path[1 .. $]) : Json(null);
}

Json getPath(Json json, string[] path) {
  if (!json.isObject || path.length == 0) {
    return Json(null);
  }

  auto firstJson = json.getValue(path[0]);
  if (path.length == 1) {
    return firstJson;
  }

  return !firstJson.isNull && path.length > 1 ? json[path[0]].getPath(path[1 .. $]) : Json(null);
}

Json getValue(Json json, string key) {
  if (!json.isObject) {
    return Json(null);
  }

  return key in json ? json[key] : Json(null);
}

Json getValue(Json json, size_t index) {
  if (!json.isArray) {
    return Json(null);
  }
  return json.length > index ? json[index] : Json(null);
}












