/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.booleans.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
bool isAllBoolean(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isBoolean) : indices.all!(
      index => jsons.isBoolean(index));
}

bool isAnyBoolean(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isBoolean) : indices.any!(
      index => jsons.isBoolean(index));
}

bool isBoolean(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isBoolean;
}
// #endregion Json[]

// #region Json[string]
bool isAllBoolean(Json[string] jsons, string[] keys = null) {
  return keys.length > 0
    ? keys.all!(key => jsons.getValue(key)
        .isBoolean) : jsons.byValue.all!(value => value.isBoolean);
}

bool isAnyBoolean(Json[string] jsons, string[] keys = null) {
  return keys.length > 0
    ? keys.any!(key => jsons.getValue(key)
        .isBoolean) : jsons.byValue.any!(value => value.isBoolean);
}

bool isBoolean(Json[string] jsons, string[] path) {
  return jsons.getValue(path).isBoolean;
}

bool isBoolean(Json[string] jsons, string key) {
  return jsons.getValue(key).isBoolean;
}
// #endregion Json[string]

// #region Json
// #region path
bool isAllBoolean(Json json, string[][] paths) {
  return json.isBoolean && paths.length > 0
    ? paths.all!(path => json.isBoolean(path)) : false;
}

bool isAnyBoolean(Json json, string[][] paths) {
  return json.isBoolean && paths.length > 0
    ? paths.any!(path => json.isBoolean(path)) : false;
}

bool isBoolean(Json json, string[] path) {
  return json.getValue(path).isBoolean;
}
// #endregion path

// #region key
bool isAllBoolean(Json json, string[] keys) {
  return json.isBoolean && keys.length > 0
    ? keys.all!(key => json.isBoolean(key)) : false;
}

bool isAnyBoolean(Json json, string[] keys) {
  return json.isBoolean && keys.length > 0
    ? keys.any!(key => json.isBoolean(key)) : false;
}

bool isBoolean(Json json, string key) {
  return json.getValue(key).isBoolean;
}
// #region key

// #region index
bool isAllBoolean(Json json, size_t[] indices) {
  return json.isBoolean && indices.length > 0
    ? indices.all!(index => json.isBoolean(index)) : false;
}

bool isAnyBoolean(Json json, size_t[] indices) {
  return json.isBoolean && indices.length > 0
    ? indices.any!(index => json.isBoolean(index)) : false;
}

bool isBoolean(Json json, size_t index) {
  return json.getValue(index).isBoolean;
}
// #endregion index

bool isBoolean(Json json) {
  return (json.type == Json.Type.bool_);
}
// #endregion Json
