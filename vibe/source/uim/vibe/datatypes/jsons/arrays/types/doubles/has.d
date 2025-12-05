module uim.vibe.datatypes.jsons.arrays.types.doubles.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
/** 
Determines if all specified double values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The double values to look for.
  
  Returns:
    true if all specified double values are found in the array, false otherwise.
*/
bool hasAllDouble(Json[] jsons, double[] values) {
  return values.all!(value => jsons.hasDouble(value));
}

// #endregion all

// #region any
/** 
Determines if any of the specified double values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The double values to look for.
  
  Returns:
    true if any of the specified double values are found in the array, false otherwise.
*/
bool hasAnyDouble(Json[] jsons, double[] values) {
  return values.any!(value => jsons.hasDouble(value));
}
///

// #endregion any

// #region is
/** 
Determines if the specified double value is present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    value = The double value to look for.
  
  Returns:
    true if the specified double value is found in the array, false otherwise.
*/
bool hasDouble(Json[] jsons, double value) {
  return jsons.any!(json => json.isDouble && json.getDouble == value);
}
// #endregion is