/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.objects.types.booleans.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
// #region value
bool isAllBoolean(Json[string] obj, string[][] paths, int value) {
  return paths.all!(p => obj.isBoolean(p, value));
}
// #endregion value

// #region noValue
bool isAllBoolean(Json[string] obj, string[][] paths) {
  return paths.all!(p => obj.isBoolean(p));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool isAnyBoolean(Json[string] obj, string[][] paths, int value) {
  return paths.any!(p => obj.isBoolean(p, value));
}
// #endregion value

// #region noValue
bool isAnyBoolean(Json[string] obj, string[][] paths) {
  return paths.any!(p => obj.isBoolean(p));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isBoolean(Json[string] obj, string[] path, int value) {
  return obj.isBoolean(path) && obj.getBoolean(path) == value;
}
// #endregion value

// #region noValue
bool isBoolean(Json[string] obj, string[] path) {
  if (obj.length == 0 || path.length == 0) {
    return false;
  }

  auto root = path[0];
  if (!(root in obj)) {
    return false;
  }

  return path.length == 1 ? obj.isBoolean(root) : obj[root].isBoolean(path[1 .. $]);
}
// #endregion noValue
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllBoolean(Json[string] obj, string[] keys) {
  return keys.all!(key => obj.isBoolean(key));
}
// #endregion all

// #region any
bool isAnyBoolean(Json[string] obj, string[] keys) {
  return keys.any!(key => obj.isBoolean(key));
}
// #endregion any

// #region is
bool isBoolean(Json[string] obj, string key) {
  if (obj.length == 0 || key.length == 0) {
    return false;
  }

  return key in obj && obj[key].isBoolean;
}
// #endregion is
// #endregion key

// #region all
bool isAllBoolean(Json[string] obj) {
  return obj.byValue.all!(v => v.isBoolean);
}
// #endregion all


