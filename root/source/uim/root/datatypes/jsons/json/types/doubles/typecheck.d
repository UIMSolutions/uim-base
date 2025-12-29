/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.doubles.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:
bool isAllBoolean(Json json, string[][] paths) {
  return paths.any!(path => json.isDouble(path));
}

bool isAnyBoolean(Json json, string[][] paths) {
  return paths.any!(path => json.isDouble(path));
}

bool isDouble(Json json, string[] path) {
  return json.getPath(path).isDouble;
}

bool isAllBoolean(Json json, string[] keys) {
  return keys.all!(key => json.isDouble(key));
}

bool isAnyBoolean(Json json, string[] keys) {
  return keys.any!(key => json.isDouble(key));
}

bool isDouble(Json json, string key) {
  return json.getKey(key).isDouble;
}

bool isAllBoolean(Json json, size_t[] indices) {
  return indices.all!(index => json.isDouble(index));
}

bool isAnyBoolean(Json json, size_t[] indices) {
  return indices.any!(index => json.isDouble(index));
}

bool isDouble(Json json, size_t index) {
  return json.getValue(index).isDouble;
}

bool isDouble(Json json) {
  return (json.type == Json.Type.float_);
}