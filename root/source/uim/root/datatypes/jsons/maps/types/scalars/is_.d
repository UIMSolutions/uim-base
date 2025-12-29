/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.maps.types.scalars.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region path
// #region all
// #region value
bool isAllString(Json[string] map, string[][] paths, int value) {
  return paths.all!(p => map.isString(p, value));
}
// #endregion value

// #region noValue
bool isAllString(Json[string] map, string[][] paths) {
  return paths.all!(p => map.isString(p));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool isAnyString(Json[string] map, string[][] paths, int value) {
  return paths.any!(p => map.isString(p, value));
}
// #endregion value

// #region noValue
bool isAnyString(Json[string] map, string[][] paths) {
  return paths.any!(p => map.isString(p));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isString(Json[string] map, string[] path, int value) {
  return map.isString(path) && map.getString(path) == value;
}
// #endregion value

// #region noValue
bool isString(Json[string] map, string[] path) {
  if (map.length == 0 || path.length == 0) {
    return false;
  }

  auto root = path[0];
  if (!(root in map)) {
    return false;
  }

  return path.length == 1 ? map.isString(root) : map[root].isString(path[1 .. $]);
}
// #endregion noValue
// #endregion is
// #endregion path

// #region key
// #region all
// #region value
bool isAllString(Json[string] map, string[] keys, int value) {
  return keys.all!(key => map.isString(key, value));
}
// #endregion value

// #region noValue
bool isAllString(Json[string] map, string[] keys) {
  return keys.all!(key => map.isString(key));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool isAnyString(Json[string] map, string[] keys, int value) {
  return keys.any!(key => map.isString(key, value));
}
// #endregion value

// #region noValue
bool isAnyString(Json[string] map, string[] keys) {
  return keys.any!(key => map.isString(key));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isString(Json[string] map, string key, int value) {
  return map.isString(key) && map.getString(key) == value;
}
// #endregion value

// #region noValue
bool isString(Json[string] map, string key) {
  if (map.length == 0 || key.length == 0) {
    return false;
  }

  return key in map && map[key].isString;
}
// #endregion noValue
// #endregion is
// #endregion key

// #region all
// #region value
bool isAllString(Json[string] map, int value) {
  return map.byValue.all!(v => v.isString(value));
}
// #endregion value

// #region noValue
bool isAllString(Json[string] map) {
  return map.byValue.all!(v => v.isString);
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool isAnyString(Json[string] map, int value) {
  return map.byValue.any!(v => v.isString(value));
}
// #endregion value

// #region noValue
bool isAnyString(Json[string] map) {
  return map.byValue.any!(v => v.isString);
}
// #endregion noValue
// #endregion any

