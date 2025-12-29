/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.strings.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:


bool isAllString(Json json, string[][] paths) {
  return paths.any!(path => json.isString(path));
}

bool isAnyString(Json json, string[][] paths) {
  return paths.any!(path => json.isString(path));
}

bool isString(Json json, string[] path) {
  return json.getPath(path).isString;
}

bool isAllString(Json json, string[] keys) {
  return keys.all!(key => json.isString(key));
}

bool isAnyString(Json json, string[] keys) {
  return keys.any!(key => json.isString(key));
}

bool isString(Json json, string key) {
  return json.getKey(key).isString;
}

bool isAllString(Json json, size_t[] indices) {
  return indices.all!(index => json.isString(index));
}

bool isAnyString(Json json, size_t[] indices) {
  return indices.any!(index => json.isString(index));
}

bool isString(Json json, size_t index) {
  return json.getValue(index).isString;
}

bool isString(Json json) {
  return (json.type == Json.Type.string);
}