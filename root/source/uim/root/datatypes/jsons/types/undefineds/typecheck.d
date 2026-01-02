/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.undefineds.typecheck;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
bool isAllUndefined(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isUndefined)
    : indices.all!(index => jsons.isUndefined(index));
}

bool isAnyUndefined(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isUndefined)
    : indices.any!(index => jsons.isUndefined(index));
}

bool isUndefined(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isUndefined;
}
// #endregion Json[]

// #region Json[string]
bool isAllUndefined(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.all!(key => jsons.getValue(key).isUndefined) 
    : jsons.byValue.all!(value => value.isUndefined);
}

bool isAnyUndefined(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.any!(key => jsons.getValue(key).isUndefined) 
    : jsons.byValue.any!(value => value.isUndefined);
}

bool isUndefined(Json[string] jsons, string key) {
  return jsons.getValue(key).isUndefined;
}
// #endregion Json[string]

// #region Json
// #region path
bool isAllUndefined(Json json, string[][] paths) {
  return json.isUndefined && paths.length > 0
    ? paths.all!(path => json.isUndefined(path)) : false;
}

bool isAnyUndefined(Json json, string[][] paths) {
  return json.isUndefined && paths.length > 0
    ? paths.any!(path => json.isUndefined(path)) : false;
}

bool isUndefined(Json json, string[] path) {
  return json.getValue(path).isUndefined;
}
// #endregion path

// #region key
bool isAllUndefined(Json json, string[] keys) {
  return json.isUndefined && keys.length > 0
    ? keys.all!(key => json.isUndefined(key)) : false;
}

bool isAnyUndefined(Json json, string[] keys) {
  return json.isUndefined && keys.length > 0
    ? keys.any!(key => json.isUndefined(key)) : false;
}

bool isUndefined(Json json, string key) {
  return json.getValue(key).isUndefined;
}
// #region key

// #region index
bool isAllUndefined(Json json, size_t[] indices) {
  return json.isUndefined && indices.length > 0
    ? indices.all!(index => json.isUndefined(index)) : false;
}

bool isAnyUndefined(Json json, size_t[] indices) {
  return json.isUndefined && indices.length > 0
    ? indices.any!(index => json.isUndefined(index)) : false;
}

bool isUndefined(Json json, size_t index) {
  return json.getValue(index).isUndefined;
}
// #endregion index

bool isUndefined(Json json) {
  return json.type == Json.Type.undefined; 
}
// #endregion Json