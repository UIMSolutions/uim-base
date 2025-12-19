/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.strings.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
/** 
Determines if all specified string values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The string values to look for.
  
  Returns:
    true if all specified string values are found in the array, false otherwise.
*/
bool hasAllString(Json[] jsons, string[] values) {
  return values.all!(value => jsons.hasString(value));
}

// #endregion all

// #region any
/** 
Determines if any of the specified string values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The string values to look for.
  
  Returns:
    true if any of the specified string values are found in the array, false otherwise.
*/
bool hasAnyString(Json[] jsons, string[] values) {
  return values.any!(value => jsons.hasString(value));
}
///

// #endregion any

// #region is
/** 
Determines if the specified string value is present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    value = The string value to look for.
  
  Returns:
    true if the specified string value is found in the array, false otherwise.
*/
bool hasString(Json[] jsons, string value) {
  return jsons.any!(json => uim.vibe.datatypes.jsons.json.types.strings.is_.isString(json) && json.getString == value);
}
// #endregion is