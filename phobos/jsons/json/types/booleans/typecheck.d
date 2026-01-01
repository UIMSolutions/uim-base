/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.booleans.typecheck;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

bool isAllBoolean(Json[] jsons) {
  return jsons.all!(json => json.isBoolean);
}

bool isAllBoolean(Json[] jsons, size_t[] indices) {
  return indices.all!(index => jsons.isBoolean(index));
}

bool isAnyBoolean(Json[] jsons) {
  return jsons.any!(json => isBoolean(json));
}

bool isAnyBoolean(Json[] jsons, size_t[] indices) {
  return indices.any!(index => jsons.isBoolean(index));
}

bool isBoolean(Json[] jsons, size_t index) {
  return jsons.length > index ? isBoolean(jsons[index]) : false;
}

bool isAllBoolean(Json json, string[][] paths) {
  return paths.any!(path => json.isBoolean(path));
}

bool isAnyBoolean(Json json, string[][] paths) {
  return paths.any!(path => json.isBoolean(path));
}

bool isBoolean(Json json, string[] path) {
  return json.getValue(path).isBoolean;
}

bool isAllBoolean(Json json, string[] keys) {
  return keys.all!(key => json.isBoolean(key));
}

bool isAnyBoolean(Json json, string[] keys) {
  return keys.any!(key => json.isBoolean(key));
}

bool isBoolean(Json json, string key) {
  return json.getValue(key).isBoolean;
}

bool isAllBoolean(Json json, size_t[] indices) {
  return indices.all!(index => json.isBoolean(index));
}

bool isAnyBoolean(Json json, size_t[] indices) {
  return indices.any!(index => json.isBoolean(index));
}

bool isBoolean(Json json, size_t index) {
  return json.getValue(index).isBoolean;
}

bool isBoolean(Json json) {
  return (json.type == Json.Type.bool_);
}