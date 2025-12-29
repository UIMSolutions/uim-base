/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.integers.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[string]
bool isAllInteger(Json[string] map, string[][] paths) {
  return paths.all!(path => map.isInteger(path));
}

bool isAnyInteger(Json[string] map, string[][] paths) {
  return paths.any!(path => map.isInteger(path));
}

bool isInteger(Json[string] map, string[] path) {
  return map.getPath(path).isInteger;
}

bool isAllInteger(Json[string] map, string[] keys = null) {
  return keys.length == 0
    ? map.byValue.all!(json => json.isInteger)
    : keys.all!(key => map.isInteger(key));
}

bool isAnyInteger(Json[string] map, string[] keys = null) {
  return keys.length == 0
    ? map.byValue.any!(json => json.isInteger)
    : keys.any!(key => map.isInteger(key));
}

bool isInteger(Json[string] map, string key) {
  return map.getValue(key).isInteger;
}
// #endregion value
// #endregion Json[string]

// #region Json[]
bool isAllInteger(Json[] values) {
  return values.all!(value => isInteger(value));
}

bool isAllInteger(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isInteger(index));
}

bool isAnyInteger(Json[] values) {
  return values.any!(value => isInteger(value));
}

bool isAnyInteger(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isInteger(index));
}

bool isInteger(Json[] values, size_t index) {
  return values.getValue(index).isInteger;
}
// #region Json[]

// #region Json
bool isAllInteger(Json json, string[][] paths) {
  return paths.any!(path => json.isInteger(path));
}

bool isAnyInteger(Json json, string[][] paths) {
  return paths.any!(path => json.isInteger(path));
}

bool isInteger(Json json, string[] path) {
  return json.getPath(path).isInteger;
}

bool isAllInteger(Json json, string[] keys) {
  return keys.all!(key => json.isInteger(key));
}

bool isAnyInteger(Json json, string[] keys) {
  return keys.any!(key => json.isInteger(key));
}

bool isInteger(Json json, string key) {
  return json.getValue(key).isInteger;
}

bool isAllInteger(Json json, size_t[] indices) {
  return indices.all!(index => json.isInteger(index));
}

bool isAnyInteger(Json json, size_t[] indices) {
  return indices.any!(index => json.isInteger(index));
}

bool isInteger(Json json, size_t index) {
  return json.getValue(index).isInteger;
}

bool isInteger(Json json) {
  return (json.type == Json.Type.int_);
}
// #region Json



