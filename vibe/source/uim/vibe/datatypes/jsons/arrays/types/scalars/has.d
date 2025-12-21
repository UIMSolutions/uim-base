/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.scalars.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
/** 
Determines if all specified scalar values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The scalar values to look for.
  
  Returns:
    true if all specified scalar values are found in the array, false otherwise.
*/
bool hasAllScalar(Json[] jsons, Json[] values) {
  return values.all!(value => jsons.hasScalar(value));
}

// #endregion all

// #region any
/** 
Determines if any of the specified scalar values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The scalar values to look for.
  
  Returns:
    true if any of the specified scalar values are found in the array, false otherwise.
*/
bool hasAnyScalar(Json[] jsons, Json[] values) {
  return values.any!(value => jsons.hasScalar(value));
}
///

// #endregion any

// #region is
/** 
Determines if the specified scalar value is present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    value = The scalar value to look for.
  
  Returns:
    true if the specified scalar value is found in the array, false otherwise.
*/
bool hasScalar(Json[] jsons) {
  return jsons.any!(json => uim.vibe.datatypes.jsons.json.types.scalars.is_.isScalar(json));
}
// #endregion is