/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.doubles.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool isAllDouble(Json[] values) {
  return values.all!(value => isDouble(value));
}

bool isAllDouble(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isDouble(index));
}

bool isAnyDouble(Json[] values) {
  return values.any!(value => isDouble(value));
}

bool isAnyDouble(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isDouble(index));
}

bool isDouble(Json[] values, size_t index) {
  return values.getValue(index).isDouble;
}

bool isAllDouble(Json json, string[][] paths) {
  return paths.any!(path => json.isDouble(path));
}

bool isAnyDouble(Json json, string[][] paths) {
  return paths.any!(path => json.isDouble(path));
}

bool isDouble(Json json, string[] path) {
  return json.getValue(path).isDouble;
}

bool isAllDouble(Json json, string[] keys) {
  return keys.all!(key => json.isDouble(key));
}

bool isAnyDouble(Json json, string[] keys) {
  return keys.any!(key => json.isDouble(key));
}

bool isDouble(Json json, string key) {
  return json.getValue(key).isDouble;
}

bool isAllDouble(Json json, size_t[] indices) {
  return indices.all!(index => json.isDouble(index));
}

bool isAnyDouble(Json json, size_t[] indices) {
  return indices.any!(index => json.isDouble(index));
}

bool isDouble(Json json, size_t index) {
  return json.getValue(index).isDouble;
}

bool isDouble(Json json) {
  return (json.type == Json.Type.float_);
}