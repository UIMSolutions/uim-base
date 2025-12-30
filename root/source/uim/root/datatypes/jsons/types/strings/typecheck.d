/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.strings.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
bool isAllString(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isString)
    : indices.all!(index => jsons.isString(index));
}

bool isAnyString(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isString)
    : indices.any!(index => jsons.isString(index));
}

bool isString(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isString;
}
// #endregion Json[]

// #region Json[string]
bool isAllString(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.all!(key => jsons.getValue(key).isString) 
    : jsons.byValue.all!(value => value.isString);
}

bool isAnyString(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.any!(key => jsons.getValue(key).isString) 
    : jsons.byValue.any!(value => value.isString);
}

bool isString(Json[string] jsons, string key) {
  return jsons.getValue(key).isString;
}
// #endregion Json[string]

// #region Json
// #region path
bool isAllString(Json json, string[][] paths) {
  return json.isString && paths.length > 0
    ? paths.all!(path => json.isString(path)) : false;
}

bool isAnyString(Json json, string[][] paths) {
  return json.isString && paths.length > 0
    ? paths.any!(path => json.isString(path)) : false;
}

bool isString(Json json, string[] path) {
  return json.getValue(path).isString;
}
// #endregion path

// #region key
bool isAllString(Json json, string[] keys) {
  return json.isString && keys.length > 0
    ? keys.all!(key => json.isString(key)) : false;
}

bool isAnyString(Json json, string[] keys) {
  return json.isString && keys.length > 0
    ? keys.any!(key => json.isString(key)) : false;
}

bool isString(Json json, string key) {
  return json.getValue(key).isString;
}
// #region key

// #region index
bool isAllString(Json json, size_t[] indices) {
  return json.isString && indices.length > 0
    ? indices.all!(index => json.isString(index)) : false;
}

bool isAnyString(Json json, size_t[] indices) {
  return json.isString && indices.length > 0
    ? indices.any!(index => json.isString(index)) : false;
}

bool isString(Json json, size_t index) {
  return json.getValue(index).isString;
}
// #endregion index

bool isString(Json json) {
  return (json.type == Json.Type.string);
}
// #endregion Json