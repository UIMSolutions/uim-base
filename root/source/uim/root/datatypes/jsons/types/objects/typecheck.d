/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.objects.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Json[]
bool isAllObject(Json[] values) {
  return values.all!(value => isObject(value));
}

bool isAllObject(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isObject(index));
}

bool isAnyObject(Json[] values) {
  return values.any!(value => isObject(value));
}

bool isAnyObject(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isObject(index));
}

bool isObject(Json[] values, size_t index) {
  return values.getValue(index).isObject;
}
// #endregion Json[]

// #region Json
// #region all
bool isAllObject(Json json, string[][] paths) {
  return paths.all!(path => json.isObject(path));
}
// #endregion all

// #region any
bool isAnyObject(Json json, string[][] paths) {
  return paths.any!(path => json.isObject(path));
}
// #endregion any

// #region is
bool isObject(Json json, string[] path) {
  return json.getPath(path).isObject;
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllObject(Json json, string[] keys) {
  return keys.all!(key => json.isObject(key));
}
// #endregion all

// #region any
bool isAnyObject(Json json, string[] keys) {
  return keys.any!(key => json.isObject(key));
}
// #endregion any

bool isObject(Json json, size_t index) {
  return json.getValue(index).isObject;
}

bool isObject(Json json, string key) {
  return json.getValue(key).isObject;
}

bool isObject(Json json) {
  return (json.type == Json.Type.object);
}
