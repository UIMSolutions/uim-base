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
  if (json.isNull || path.length == 0) {
    return true;
  }

  auto firstKey = path[0];
  if (json.isNull(firstKey)) {
    return true;
  }

  return path.length > 1 && json[firstKey].isNull(path[1 .. $]);
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
  if (json.isNull) {
    return true;
  }

  return json.isObject && key in json ? json[key].isNull : true;
}
// #endregion is
// #endregion key

// #region scalar

// #endregion scalar