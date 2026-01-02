/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.nulls.typecheck;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
bool isAllNull(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.all!(value => value.isNull)
    : indices.all!(index => jsons.isNull(index));
}

bool isAnyNull(Json[] jsons, size_t[] indices = null) {
  return indices.length == 0
    ? jsons.length > 0 && jsons.any!(value => value.isNull)
    : indices.any!(index => jsons.isNull(index));
}

bool isNull(Json[] jsons, size_t index) {
  return jsons.length > index && jsons.getValue(index).isNull;
}
// #endregion Json[]

// #region Json[string]
bool isAllNull(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.all!(key => jsons.getValue(key).isNull) 
    : jsons.byValue.all!(value => value.isNull);
}

bool isAnyNull(Json[string] jsons, string[] keys = null) {
  return keys.length > 0 
    ? keys.any!(key => jsons.getValue(key).isNull) 
    : jsons.byValue.any!(value => value.isNull);
}

bool isNull(Json[string] jsons, string key) {
  return key in jsons ? jsons[key].isNull : false;
}
// #endregion Json[string]

// #region Json
// #region path
bool isAllNull(Json json, string[][] paths) {
  return json.isNull && paths.length > 0
    ? paths.all!(path => json.isNull(path)) : false;
}

bool isAnyNull(Json json, string[][] paths) {
  return json.isNull && paths.length > 0
    ? paths.any!(path => json.isNull(path)) : false;
}

bool isNull(Json json, string[] path) {
  return json.getValue(path).isNull;
}
// #endregion path

// #region key
bool isAllNull(Json json, string[] keys) {
  return json.isNull && keys.length > 0
    ? keys.all!(key => json.isNull(key)) : false;
}

bool isAnyNull(Json json, string[] keys) {
  return json.isNull && keys.length > 0
    ? keys.any!(key => json.isNull(key)) : false;
}

bool isNull(Json json, string key) {
  return json.getValue(key).isNull;
}
// #region key

// #region index
bool isAllNull(Json json, size_t[] indices) {
  return json.isNull && indices.length > 0
    ? indices.all!(index => json.isNull(index)) : false;
}

bool isAnyNull(Json json, size_t[] indices) {
  return json.isNull && indices.length > 0
    ? indices.any!(index => json.isNull(index)) : false;
}

bool isNull(Json json, size_t index) {
  return json.getValue(index).isNull;
}
// #endregion index

bool isNull(Json json) {
  return json == Json(null); 
}
// #endregion Json