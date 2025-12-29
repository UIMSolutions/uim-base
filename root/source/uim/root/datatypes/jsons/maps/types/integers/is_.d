/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.maps.types.integers.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region path
// #region all
// #region value
bool isAllInteger(Json[string] map, string[][] paths, int value) {
  return paths.all!(p => map.isInteger(p, value));
}
// #endregion value

// #region noValue
bool isAllInteger(Json[string] map, string[][] paths) {
  return paths.all!(p => map.isInteger(p));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool isAnyInteger(Json[string] map, string[][] paths, int value) {
  return paths.any!(p => map.isInteger(p, value));
}
// #endregion value

// #region noValue
bool isAnyInteger(Json[string] map, string[][] paths) {
  return paths.any!(p => map.isInteger(p));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isInteger(Json[string] map, string[] path, int value) {
  return map.isInteger(path) && map.getInteger(path) == value;
}
// #endregion value

// #region noValue
bool isInteger(Json[string] map, string[] path) {
  if (map.length == 0 || path.length == 0) {
    return false;
  }

  auto root = path[0];
  if (!(root in map)) {
    return false;
  }

  return path.length == 1 ? map.isInteger(root) : map[root].isInteger(path[1 .. $]);
}
// #endregion noValue
// #endregion is
// #endregion path

// #region key
// #region all
// #region value
bool isAllInteger(Json[string] map, string[] keys, int value) {
  return keys.all!(key => map.isInteger(key, value));
}
// #endregion value

// #region noValue
bool isAllInteger(Json[string] map, string[] keys) {
  return keys.all!(key => map.isInteger(key));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool isAnyInteger(Json[string] map, string[] keys, int value) {
  return keys.any!(key => map.isInteger(key, value));
}
// #endregion value

// #region noValue
bool isAnyInteger(Json[string] map, string[] keys) {
  return keys.any!(key => map.isInteger(key));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isInteger(Json[string] map, string key, int value) {
  return map.isInteger(key) && map.getInteger(key) == value;
}
// #endregion value

// #region noValue
bool isInteger(Json[string] map, string key) {
  if (map.length == 0 || key.length == 0) {
    return false;
  }

  return key in map && map[key].isInteger;
}
// #endregion noValue
// #endregion is
// #endregion key

// #region all
// #region value
bool isAllInteger(Json[string] map, int value) {
  return map.byValue.all!(v => v.isInteger(value));
}
// #endregion value

// #region noValue
bool isAllInteger(Json[string] map) {
  return map.byValue.all!(v => v.isInteger);
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool isAnyInteger(Json[string] map, int value) {
  return map.byValue.any!(v => v.isInteger(value));
}
// #endregion value

// #region noValue
bool isAnyInteger(Json[string] map) {
  return map.byValue.any!(v => v.isInteger);
}
// #endregion noValue
// #endregion any
