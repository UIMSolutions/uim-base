/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject get the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json getPath(Json json, string[] path) {
  if (!json.isObject || path.length == 0) {
    return Json(null);
  }

  auto firstJson = json.getKey(path[0]);
  if (path.length == 1) {
    return firstJson;
  }

  return !firstJson.isNull && path.length > 1 ? json[path[0]].getPath(path[1 .. $]) : Json(null);
}

Json getKey(Json json, string key) {
  if (!json.isObject || key.length == 0) {
    return Json(null);
  }

  return (key in json) ? json[key] : Json(null);
}









