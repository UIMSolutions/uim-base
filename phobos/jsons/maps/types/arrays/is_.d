/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.maps.types.arrays.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region path
// #region all
bool isAllArray(Json[string] map, string[][] paths) {
  return paths.all!(p => map.isArray(p));
}
// #endregion all

// #region any
bool isAnyArray(Json[string] map, string[][] paths) {
  return paths.any!(p => map.isArray(p));
}
// #endregion any

// #region is
bool isArray(Json[string] map, string[] path) {
  if (map.length == 0 || path.length == 0) {
    return false;
  }

  auto root = path[0];
  if (!(root in map)) {
    return false;
  }

  return path.length == 1 ? map.isArray(root) : map[root].isArray(path[1 .. $]);
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllArray(Json[string] map, string[] keys) {
  return keys.all!(key => map.isArray(key));
}
// #endregion all

// #region any
bool isAnyArray(Json[string] map, string[] keys) {
  return keys.any!(key => map.isArray(key));
}
// #endregion any

// #region is
bool isArray(Json[string] map, string key) {
  if (map.length == 0 || key.length == 0) {
    return false;
  }

  return key in map && map[key].isArray;
}
// #endregion is
// #endregion key

// #region all
bool isAllArray(Json[string] map) {
  return map.byValue.all!(v => v.isArray);
}
// #endregion all

// #region any
bool isAnyArray(Json[string] map) {
  return map.byValue.any!(v => v.isArray);
}
// #endregion any

