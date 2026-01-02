/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.strings.typecheck;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:


// #region all
// #region noIndex
bool isAllString(Json[] values) {
  import uim.root.datatypes.jsons.json.types.strings.typecheck;
  return values.all!(value => isString(value));
}
// #endregion noIndex

// #region index  
bool isAllString(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isString(index));
}

bool isAnyString(Json[] values) {
  return values.any!(value => isString(value));
}
// #endregion noIndex

// #region index
bool isAnyString(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isString(index));
}

bool isString(Json[] values, size_t index) {
  return values.getValue(index).isString;
}
// #endregion is

bool isAllString(Json json, string[][] paths) {
  return paths.any!(path => json.isString(path));
}

bool isAnyString(Json json, string[][] paths) {
  return paths.any!(path => json.isString(path));
}

bool isString(Json json, string[] path) {
  return json.getValue(path).isString;
}

bool isAllString(Json json, string[] keys) {
  return keys.all!(key => json.isString(key));
}

bool isAnyString(Json json, string[] keys) {
  return keys.any!(key => json.isString(key));
}

bool isString(Json json, string key) {
  return json.getValue(key).isString;
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