/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.arrays.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool isAllArray(Json json, string[][] paths) {
  return paths.any!(path => json.isArray(path));
}

bool isAnyArray(Json json, string[][] paths) {
  return paths.any!(path => json.isArray(path));
}

bool isArray(Json json, string[] path) {
  return json.getPath(path).isArray;
}

bool isAllArray(Json json, string[] keys) {
  return keys.all!(key => json.isArray(key));
}

bool isAnyArray(Json json, string[] keys) {
  return keys.any!(key => json.isArray(key));
}

bool isArray(Json json, string key) {
  return json.getKey(key).isArray;
}

bool isAllArray(Json json, size_t[] indices) {
  return indices.all!(index => json.isArray(index));
}

bool isAnyArray(Json json, size_t[] indices) {
  return indices.any!(index => json.isArray(index));
}

bool isArray(Json json, size_t index) {
  return json.getValue(index).isArray;
}

bool isArray(Json json) {
  return (json.type == Json.Type.array);
}