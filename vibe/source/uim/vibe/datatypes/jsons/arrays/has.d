/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
/* 
bool hasAllArray(Json[] jsons, Json[] values) {
  return values.all!(value => jsons.hasArray(value));
}

// #endregion all

// #region any
bool hasAnyArray(Json[] jsons, Json[] values) {
  return values.any!(value => jsons.hasArray(value));
}
///

// #endregion any

// #region has
bool hasArray(Json[] jsons, Json value) {
  if (!value.isArray) {
    return false;
  }
  return jsons.any!(json => json.isArray && json == value);
} */ 
// #endregion has
