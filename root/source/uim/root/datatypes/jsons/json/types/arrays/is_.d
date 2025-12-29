/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.arrays.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region path
// #region all
bool isAllArray(Json json, string[][] paths) {
  return paths.all!(path => json.isArray(path));
}
// #endregion all

// #region any
bool isAnyArray(Json json, string[][] paths) {
  return paths.any!(path => json.isArray(path));
}
// #endregion any

// #region is
bool isArray(Json json, string[] path) {
  if (json.isArray || path.length == 0) {
    return true;
  }

  auto firstKey = path[0];
  if (json.isArray(firstKey)) {
    return true;
  }

  return path.length > 1 && json[firstKey].isArray(path[1 .. $]);
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllArray(Json json, string[] keys) {
  return keys.all!(key => json.isArray(key));
}
// #endregion all

// #region any
bool isAnyArray(Json json, string[] keys) {
  return keys.any!(key => json.isArray(key));
}
// #endregion any

// #region is
bool isArray(Json json, size_t index) {
  if (!json.isArray || index >= json.getArray.length) {
    return false;
  }
  return json[index].isArray;
}


// #endregion scalar
// #endregion scalar