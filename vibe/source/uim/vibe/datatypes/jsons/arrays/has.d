module uim.vibe.datatypes.jsons.arrays.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
/** 
Determines if all specified array values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The array values to look for.
  
  Returns:
    true if all specified array values are found in the array, false otherwise.
*/
bool hasAllArray(Json[] jsons, Json[] values) {
  return values.all!(value => jsons.hasArray(value));
}

// #endregion all

// #region any
/** 
Determines if any of the specified array values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The array values to look for.
  
  Returns:
    true if any of the specified array values are found in the array, false otherwise.
*/
bool hasAnyArray(Json[] jsons, Json[] values) {
  return values.any!(value => jsons.hasArray(value));
}
///

// #endregion any

// #region is
/** 
Determines if the specified array value is present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    value = The array value to look for.
  
  Returns:
    true if the specified array value is found in the array, false otherwise.
*/
bool hasArray(Json[] jsons, Json value) {
  if (!value.isArray) {
    return false;
  }
  return jsons.any!(json => json.isArray && json == value);
}
// #endregion is