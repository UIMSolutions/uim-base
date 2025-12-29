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
  return json.isObject && (key in json) ? json[key] : Json(null);
}

Json getValue(Json json, size_t index) {
  return json.isArray && json.length > index ? json[index] : Json(null); 
}

Json getValue(Json[] jsons, size_t index) {
  return jsons.length > index ? jsons[index] : Json(null); 
}








