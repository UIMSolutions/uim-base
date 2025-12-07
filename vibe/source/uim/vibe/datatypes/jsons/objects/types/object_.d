/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.objects.types.object_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
bool isAllObject(Json[string] map, string[][] paths) {
  return paths.all!(p => map.isObject(p));
}
// #endregion all

// #region any
bool isAnyObject(Json[string] map, string[][] paths) {
  return paths.any!(p => map.isObject(p));
}
// #endregion any

// #region is
bool isObject(Json[string] map, string[] path) {
  if (map.length == 0 || path.length == 0) {
    return false;
  }

  auto root = path[0];
  if (!(root in map)) {
    return false;
  }

  return path.length == 1 ? map.isObject(root) : map[root].isObject(path[1 .. $]);
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllObject(Json[string] map, string[] keys) {
  return keys.all!(key => map.isObject(key));
}
// #endregion all

// #region any
bool isAnyObject(Json[string] map, string[] keys) {
  return keys.any!(key => map.isObject(key));
}
// #endregion any

// #region is
bool isObject(Json[string] map, string key) {
  if (map.length == 0 || key.length == 0) {
    return false;
  }

  return key in map && map[key].isObject;
}
// #endregion is
// #endregion key

// #region all
bool isAllObject(Json[string] map) {
  return map.byValue.all!(v => v.isObject);
}
// #endregion all

// #region any
bool isAnyObject(Json[string] map) {
  return map.byValue.any!(v => v.isObject);
}
// #endregion any

