module uim.vibe.datatypes.jsons.arrays.types.integers.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
/** 
Determines if all specified integer values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The integer values to look for.
  
  Returns:
    true if all specified integer values are found in the array, false otherwise.
*/
bool hasAllInteger(Json[] jsons, integer[] values) {
  return values.all!(value => jsons.hasInteger(value));
}

// #endregion all

// #region any
/** 
Determines if any of the specified integer values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The integer values to look for.
  
  Returns:
    true if any of the specified integer values are found in the array, false otherwise.
*/
bool hasAnyInteger(Json[] jsons, integer[] values) {
  return values.any!(value => jsons.hasInteger(value));
}
///

// #endregion any

// #region is
/** 
Determines if the specified integer value is present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    value = The integer value to look for.
  
  Returns:
    true if the specified integer value is found in the array, false otherwise.
*/
bool hasInteger(Json[] jsons, integer value) {
  return jsons.any!(json => json.isInteger && json.getInteger == value);
}
// #endregion is
