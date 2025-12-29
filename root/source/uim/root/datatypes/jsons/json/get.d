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

  if (path.length == 1) {
    return json.hasKey(path[0]) ? json[path[0]] : Json(null);
  }

  // If the first key in the path does not exist, return false
  if (!json.hasKey(path[0])) {
    return Json(null);
  }

  return path.length > 1 && json[path[0]].getPath(path[1 .. $]);
}





