/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:





bool isUndefined(Json json, size_t index) {
  return json.isArray && index < json.length && json[index].isUndefined;
}

bool isUndefined(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isUndefined;
}

bool isUndefined(Json json) {
  return json.type == Json.Type.undefined; 
}