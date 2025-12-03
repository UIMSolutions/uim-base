/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.maps.types.boolean;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
// #region value
bool allBoolean(Json[string] map, string[][] paths, int value) {
  return paths.all!(p => map.isBoolean(p, value));
}
// #endregion value

// #region noValue
bool allBoolean(Json[string] map, string[][] paths) {
  return paths.all!(p => map.isBoolean(p));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool anyBoolean(Json[string] map, string[][] paths, int value) {
  return paths.any!(p => map.isBoolean(p, value));
}
// #endregion value

// #region noValue
bool anyBoolean(Json[string] map, string[][] paths) {
  return paths.any!(p => map.isBoolean(p));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isBoolean(Json[string] map, string[] path, int value) {
  return map.isBoolean(path) && map.getBoolean(path) == value;
}
// #endregion value

// #region noValue
bool isBoolean(Json[string] map, string[] path) {
  if (map.length == 0 || path.length == 0) {
    return false;
  }

  auto root = path[0];
  if (!(root in map)) {
    return false;
  }

  return path.length == 1 ? map.isBoolean(root) : map[root].isBoolean(path[1 .. $]);
}
// #endregion noValue
// #endregion is
// #endregion path

// #region key
// #region all
// #region value
bool allBoolean(Json[string] map, string[] keys, int value) {
  return keys.all!(key => map.isBoolean(key, value));
}
// #endregion value

// #region noValue
bool allBoolean(Json[string] map, string[] keys) {
  return keys.all!(key => map.isBoolean(key));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool anyBoolean(Json[string] map, string[] keys, int value) {
  return keys.any!(key => map.isBoolean(key, value));
}
// #endregion value

// #region noValue
bool anyBoolean(Json[string] map, string[] keys) {
  return keys.any!(key => map.isBoolean(key));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isBoolean(Json[string] map, string key, int value) {
  return map.isBoolean(key) && map.getBoolean(key) == value;
}
// #endregion value

// #region noValue
bool isBoolean(Json[string] map, string key) {
  if (map.length == 0 || key.length == 0) {
    return false;
  }

  return key in map && map[key].isBoolean;
}
// #endregion noValue
// #endregion is
// #endregion key

// #region all
// #region value
bool allBoolean(Json[string] map, int value) {
  return map.byValue.all!(v => v.isBoolean(value));
}
// #endregion value

// #region noValue
bool allBoolean(Json[string] map) {
  return map.byValue.all!(v => v.isBoolean);
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool anyBoolean(Json[string] map, int value) {
  return map.byValue.any!(v => v.isBoolean(value));
}
// #endregion value

// #region noValue
bool anyBoolean(Json[string] map) {
  return map.byValue.any!(v => v.isBoolean);
}
// #endregion noValue
// #endregion any

