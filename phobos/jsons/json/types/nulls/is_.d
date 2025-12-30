/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.nulls.is_;


import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region path
// #region all
bool isAllNull(Json json, string[][] paths) {
  return paths.all!(path => json.isNull(path));
}
// #endregion all

// #region any
bool isAnyNull(Json json, string[][] paths) {
  return paths.any!(path => json.isNull(path));
}
// #endregion any

// #region is
bool isNull(Json json, string[] path) {

  return json.hasPath(path) ? json.getPath(path).isNull : false;
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllNull(Json json, string[] keys) {
  return keys.all!(key => json.isNull(key));
}
// #endregion all

// #region any
bool isAnyNull(Json json, string[] keys) {
  return keys.any!(key => json.isNull(key));
}
// #endregion any

// #region is
bool isNull(Json json, string key) {
  return json.hasKey(key) ? json.getValue(key).isNull : false;
}
// #endregion is
// #endregion key

// #region scalar

// #endregion scalar

bool isAllNull(Json json, size_t[] indices) {
  return indices.all!(index => json.isNull(index));
}
// #endregion all

// #region any
bool isAnyNull(Json json, size_t[] indices) {
  return indices.any!(index => json.isNull(index));
}

bool isNull(Json json, size_t index) {
  return json.hasValue(index) ? json[index].isNull : false;
}

bool isNull(Json json) {
  return json == Json(null); 
}
