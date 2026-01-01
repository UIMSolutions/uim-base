/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.doubles.typecheck;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
bool isAllDouble(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isDouble)
    : indices.all!(index => jsons.isDouble(index));
}

bool isAnyDouble(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isDouble)
    : indices.any!(index => jsons.isDouble(index));
}

bool isDouble(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isDouble;
}
// #endregion Json[]

// #region Json[string]
bool isAllDouble(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.all!(key => jsons.getValue(key).isDouble) 
    : jsons.byValue.all!(value => value.isDouble);
}

bool isAnyDouble(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.any!(key => jsons.getValue(key).isDouble) 
    : jsons.byValue.any!(value => value.isDouble);
}

bool isDouble(Json[string] jsons, string key) {
  return jsons.getValue(key).isDouble;
}
// #endregion Json[string]

// #region Json
// #region path
bool isAllDouble(Json json, string[][] paths) {
  return json.isDouble && paths.length > 0
    ? paths.all!(path => json.isDouble(path)) : false;
}

bool isAnyDouble(Json json, string[][] paths) {
  return json.isDouble && paths.length > 0
    ? paths.any!(path => json.isDouble(path)) : false;
}

bool isDouble(Json json, string[] path) {
  return json.getValue(path).isDouble;
}
// #endregion path

// #region key
bool isAllDouble(Json json, string[] keys) {
  return json.isDouble && keys.length > 0
    ? keys.all!(key => json.isDouble(key)) : false;
}

bool isAnyDouble(Json json, string[] keys) {
  return json.isDouble && keys.length > 0
    ? keys.any!(key => json.isDouble(key)) : false;
}

bool isDouble(Json json, string key) {
  return json.getValue(key).isDouble;
}
// #region key

// #region index
bool isAllDouble(Json json, size_t[] indices) {
  return json.isDouble && indices.length > 0
    ? indices.all!(index => json.isDouble(index)) : false;
}

bool isAnyDouble(Json json, size_t[] indices) {
  return json.isDouble && indices.length > 0
    ? indices.any!(index => json.isDouble(index)) : false;
}

bool isDouble(Json json, size_t index) {
  return json.getValue(index).isDouble;
}
// #endregion index

bool isDouble(Json json) {
  return (json.type == Json.Type.float_);
}
// #endregion Json