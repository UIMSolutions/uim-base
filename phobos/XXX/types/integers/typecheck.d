/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.integers.typecheck;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
bool isAllInteger(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isInteger)
    : indices.all!(index => jsons.isInteger(index));
}

bool isAnyInteger(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isInteger)
    : indices.any!(index => jsons.isInteger(index));
}

bool isInteger(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isInteger;
}
// #endregion Json[]

// #region Json[string]
bool isAllInteger(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.all!(key => jsons.getValue(key).isInteger) 
    : jsons.byValue.all!(value => value.isInteger);
}

bool isAnyInteger(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.any!(key => jsons.getValue(key).isInteger) 
    : jsons.byValue.any!(value => value.isInteger);
}

bool isInteger(Json[string] jsons, string key) {
  return jsons.getValue(key).isInteger;
}
// #endregion Json[string]

// #region Json
// #region path
bool isAllInteger(Json json, string[][] paths) {
  return json.isInteger && paths.length > 0
    ? paths.all!(path => json.isInteger(path)) : false;
}

bool isAnyInteger(Json json, string[][] paths) {
  return json.isInteger && paths.length > 0
    ? paths.any!(path => json.isInteger(path)) : false;
}

bool isInteger(Json json, string[] path) {
  return json.getValue(path).isInteger;
}
// #endregion path

// #region key
bool isAllInteger(Json json, string[] keys) {
  return json.isInteger && keys.length > 0
    ? keys.all!(key => json.isInteger(key)) : false;
}

bool isAnyInteger(Json json, string[] keys) {
  return json.isInteger && keys.length > 0
    ? keys.any!(key => json.isInteger(key)) : false;
}

bool isInteger(Json json, string key) {
  return json.getValue(key).isInteger;
}
// #region key

// #region index
bool isAllInteger(Json json, size_t[] indices) {
  return json.isInteger && indices.length > 0
    ? indices.all!(index => json.isInteger(index)) : false;
}

bool isAnyInteger(Json json, size_t[] indices) {
  return json.isInteger && indices.length > 0
    ? indices.any!(index => json.isInteger(index)) : false;
}

bool isInteger(Json json, size_t index) {
  return json.getValue(index).isInteger;
}
// #endregion index

bool isInteger(Json json) {
}
// #endregion Json