/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.maps.types.doubles.is_;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:
// #region path
// #region all
// #region value
bool allDouble(Json[string] map, string[][] paths, int value) {
  return paths.all!(p => map.isDouble(p, value));
}
// #endregion value

// #region noValue
bool allDouble(Json[string] map, string[][] paths) {
  return paths.all!(p => map.isDouble(p));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool anyDouble(Json[string] map, string[][] paths, int value) {
  return paths.any!(p => map.isDouble(p, value));
}
// #endregion value

// #region noValue
bool anyDouble(Json[string] map, string[][] paths) {
  return paths.any!(p => map.isDouble(p));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isDouble(Json[string] map, string[] path, int value) {
  return map.isDouble(path) && map.getDouble(path) == value;
}
// #endregion value

// #region noValue
bool isDouble(Json[string] map, string[] path) {
  if (map.length == 0 || path.length == 0) {
    return false;
  }

  auto root = path[0];
  if (!(root in map)) {
    return false;
  }

  return path.length == 1 ? map.isDouble(root) : map[root].isDouble(path[1 .. $]);
}
// #endregion noValue
// #endregion is
// #endregion path

// #region key
// #region all
// #region value
bool allDouble(Json[string] map, string[] keys, int value) {
  return keys.all!(key => map.isDouble(key, value));
}
// #endregion value

// #region noValue
bool allDouble(Json[string] map, string[] keys) {
  return keys.all!(key => map.isDouble(key));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool anyDouble(Json[string] map, string[] keys, int value) {
  return keys.any!(key => map.isDouble(key, value));
}
// #endregion value

// #region noValue
bool anyDouble(Json[string] map, string[] keys) {
  return keys.any!(key => map.isDouble(key));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isDouble(Json[string] map, string key, int value) {
  return map.isDouble(key) && map.getDouble(key) == value;
}
// #endregion value

// #region noValue
bool isDouble(Json[string] map, string key) {
  if (map.length == 0 || key.length == 0) {
    return false;
  }

  return key in map && map[key].isDouble;
}
// #endregion noValue
// #endregion is
// #endregion key

// #region all
// #region value
bool allDouble(Json[string] map, int value) {
  return map.byValue.all!(v => v.isDouble(value));
}
// #endregion value

// #region noValue
bool allDouble(Json[string] map) {
  return map.byValue.all!(v => v.isDouble);
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool anyDouble(Json[string] map, int value) {
  return map.byValue.any!(v => v.isDouble(value));
}
// #endregion value

// #region noValue
bool anyDouble(Json[string] map) {
  return map.byValue.any!(v => v.isDouble);
}
// #endregion noValue
// #endregion any

