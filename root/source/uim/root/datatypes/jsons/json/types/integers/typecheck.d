/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.integers.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool isAllBoolean(Json json, string[][] paths) {
  return paths.any!(path => json.isInteger(path));
}

bool isAnyBoolean(Json json, string[][] paths) {
  return paths.any!(path => json.isInteger(path));
}

bool isInteger(Json json, string[] path) {
  return json.getPath(path).isInteger;
}

bool isAllBoolean(Json json, string[] keys) {
  return keys.all!(key => json.isInteger(key));
}

bool isAnyBoolean(Json json, string[] keys) {
  return keys.any!(key => json.isInteger(key));
}

bool isInteger(Json json, string key) {
  return json.getKey(key).isInteger;
}

bool isAllBoolean(Json json, size_t[] indices) {
  return indices.all!(index => json.isInteger(index));
}

bool isAnyBoolean(Json json, size_t[] indices) {
  return indices.any!(index => json.isInteger(index));
}

bool isInteger(Json json, size_t index) {
  return json.getValue(index).isInteger;
}

bool isInteger(Json json) {
  return (json.type == Json.Type.int_);
}