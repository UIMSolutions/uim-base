/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.objects.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
bool isAllObject(Json json, string[][] paths) {
  return paths.all!(path => json.isObject(path));
}
// #endregion all

// #region any
bool isAnyObject(Json json, string[][] paths) {
  return paths.any!(path => json.isObject(path));
}
// #endregion any

// #region is
bool isObject(Json json, string[] path) {
  if (json.isObject || path.length == 0) {
    return true;
  }

  auto firstKey = path[0];
  if (json.isObject(firstKey)) {
    return true;
  }

  return path.length > 1 && json[firstKey].isObject(path[1 .. $]);
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllObject(Json json, string[] keys) {
  return keys.all!(key => json.isObject(key));
}
// #endregion all

// #region any
bool isAnyObject(Json json, string[] keys) {
  return keys.any!(key => json.isObject(key));
}
// #endregion any

// #region is
bool isObject(Json json, string key) {
  if (!json.isObject) {
    return false;
  }

  return key in json && json[key].isObject;
}
// #endregion is
// #endregion key
// #endregion scalar


// #endregion scalar
