/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.undefineds.typecheck;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region path
// #region all
bool isAllUndefined(Json json, string[][] paths) {
  return paths.all!(path => json.isUndefined(path));
}
// #endregion all

// #region any
bool isAnyUndefined(Json json, string[][] paths) {
  return paths.any!(path => json.isUndefined(path));
}
// #endregion any

// #region is
bool isUndefined(Json json, string[] path) {
  return json.getPath(path).isUndefined;
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllUndefined(Json json, string[] keys) {
  return keys.all!(key => json.isUndefined(key));
}
// #endregion all

// #region any
bool isAnyUndefined(Json json, string[] keys) {
  return keys.any!(key => json.isUndefined(key));
}
// #endregion any

// #region is
bool isUndefined(Json json, string key) {
  return json.isObject && key in json && json[key].isUndefined;
}
// #endregion is
// #endregion key
