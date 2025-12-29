/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool isArray(Json json) {
  return (json.type == Json.Type.array);
}

bool isObject(Json json) {
  return (json.type == Json.Type.object);
}

bool isBoolean(Json json) {
  return (json.type == Json.Type.bool_);
}

bool isInteger(Json json) {
  return (json.type == Json.Type.int_);
}

bool isDouble(Json json) {
  return (json.type == Json.Type.float_);
}

bool isString(Json json) {
  return (json.type == Json.Type.string);
}

bool isNull(Json json) {
  return json == Json(null); 
}

bool isUndefined(Json json) {
  return json.type == Json.Type.undefined; 
}