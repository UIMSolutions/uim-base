/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.arrays.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region path
// #region all
bool isAllArray(Json json, string[][] paths) {
  return json.isObject ? paths.all!(path => json.isArray(path)) : false;
}
// #endregion all

// #region any
bool isAnyArray(Json json, string[][] paths) {
  return json.isObject ? paths.any!(path => json.isArray(path)) : false;
}
// #endregion any

// #region is
bool isArray(Json json, string[] path) {
  return json.getPath(path).isArray;
}
// #endregion is

// #region key
// #region all
bool isAllArray(Json json, string[] keys) {
  import uim.root.datatypes.jsons.typecheck;

  return json.isObject ? keys.all!(key => json.isArray(key)) : false;
}
// #endregion all

// #region any
bool isAnyArray(Json json, string[] keys) {
  import uim.root.datatypes.jsons.typecheck;

  return json.isObject ? keys.any!(key => json.isArray(key)) : false;
}
// #endregion any
// #endregion scalar
