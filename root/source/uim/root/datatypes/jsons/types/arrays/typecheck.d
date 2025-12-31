/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.arrays.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
bool isAllArray(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isArray)
    : indices.all!(index => jsons.isArray(index));
}

bool isAnyArray(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isArray)
    : indices.any!(index => jsons.isArray(index));
}

bool isArray(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isArray;
}
// #endregion Json[]

// #region Json[string]
bool isAllArray(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.all!(key => jsons.getValue(key).isArray) 
    : jsons.byValue.all!(value => value.isArray);
}

bool isAnyArray(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.any!(key => jsons.getValue(key).isArray) 
    : jsons.byValue.any!(value => value.isArray);
}

bool isArray(Json[string] jsons, string[] path) {
  return jsons.getValue(path).isArray;
}

bool isArray(Json[string] jsons, string key) {
  return jsons.getValue(key).isArray;
}
// #endregion Json[string]

// #region Json
// #region path
bool isAllArray(Json json, string[][] paths) {
  return json.isArray && paths.length > 0
    ? paths.all!(path => json.isArray(path)) : false;
}

bool isAnyArray(Json json, string[][] paths) {
  return json.isArray && paths.length > 0
    ? paths.any!(path => json.isArray(path)) : false;
}

bool isArray(Json json, string[] path) {
  return json.getValue(path).isArray;
}
// #endregion path

// #region key
bool isAllArray(Json json, string[] keys) {
  return json.isArray && keys.length > 0
    ? keys.all!(key => json.isArray(key)) : false;
}

bool isAnyArray(Json json, string[] keys) {
  return json.isArray && keys.length > 0
    ? keys.any!(key => json.isArray(key)) : false;
}

bool isArray(Json json, string key) {
  return json.getValue(key).isArray;
}
// #region key

// #region index
bool isAllArray(Json json, size_t[] indices) {
  return json.isArray && indices.length > 0
    ? indices.all!(index => json.isArray(index)) : false;
}

bool isAnyArray(Json json, size_t[] indices) {
  return json.isArray && indices.length > 0
    ? indices.any!(index => json.isArray(index)) : false;
}

bool isArray(Json json, size_t index) {
  return json.getValue(index).isArray;
}
// #endregion index

bool isArray(Json json) {
  return (json.type == Json.Type.array);
}
// #endregion Json