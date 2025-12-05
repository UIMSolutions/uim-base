module uim.vibe.datatypes.jsons.arrays.types.booleans.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
/** 
Determines if all specified boolean values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The boolean values to look for.
  
  Returns:
    true if all specified boolean values are found in the array, false otherwise.
*/
bool hasAllBoolean(Json[] jsons, bool[] values) {
  return values.all!(value => jsons.hasBoolean(value));
}
///
unittest {
  // hasAllBoolean - all values present
  Json[] jsons1 = [Json(true), Json(false), Json(true)];
  assert(hasAllBoolean(jsons1, [true, false]) == true);

  // hasAllBoolean - not all values present
  Json[] jsons2 = [Json(true), Json(42)];
  assert(hasAllBoolean(jsons2, [true, false]) == false);

  // hasAllBoolean - empty values array
  Json[] jsons3 = [Json(true), Json(false)];
  assert(hasAllBoolean(jsons3, []) == true);

  // hasAllBoolean - empty jsons array
  Json[] jsons4 = [];
  assert(hasAllBoolean(jsons4, [true]) == false);

  // hasAllBoolean - single value match
  Json[] jsons5 = [Json(true)];
  assert(hasAllBoolean(jsons5, [true]) == true);

  // hasAllBoolean - no boolean values in array
  Json[] jsons6 = [Json(42), Json("text")];
  assert(hasAllBoolean(jsons6, [true, false]) == false);
}
// #endregion all

// #region any
/** 
Determines if any of the specified boolean values are present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    values = The boolean values to look for.
  
  Returns:
    true if any of the specified boolean values are found in the array, false otherwise.
*/
bool hasAnyBoolean(Json[] jsons, bool[] values) {
  return values.any!(value => jsons.hasBoolean(value));
}
///

unittest {
  // hasAnyBoolean - true value found
  Json[] jsons1 = [Json(true), Json(42), Json("text")];
  assert(hasAnyBoolean(jsons1, [true, false]) == true);

  // hasAnyBoolean - false value found
  Json[] jsons2 = [Json(false), Json(42), Json("text")];
  assert(hasAnyBoolean(jsons2, [true, false]) == true);

  // hasAnyBoolean - no values found
  Json[] jsons3 = [Json(42), Json("text")];
  assert(hasAnyBoolean(jsons3, [true, false]) == false);

  // hasAnyBoolean - empty array
  Json[] jsons4 = [];
  assert(hasAnyBoolean(jsons4, [true, false]) == false);

  // hasAnyBoolean - empty values array
  Json[] jsons5 = [Json(true), Json(false)];
  assert(hasAnyBoolean(jsons5, []) == false);

  // hasAnyBoolean - single value match
  Json[] jsons6 = [Json(true)];
  assert(hasAnyBoolean(jsons6, [false]) == false);
}
// #endregion any

// #region is
/** 
Determines if the specified boolean value is present in the given array of Jsons.
  
  Params:
    jsons = The array of Jsons to check.
    value = The boolean value to look for.
  
  Returns:
    true if the specified boolean value is found in the array, false otherwise.
*/
bool hasBoolean(Json[] jsons, bool value) {
  return jsons.any!(json => json.isBoolean && json.getBoolean == value);
}
// 
unittest {
  // hasBoolean - true value found
  Json[] jsons1 = [Json(true), Json(false), Json(42)];
  assert(hasBoolean(jsons1, true) == true);

  // hasBoolean - false value found
  Json[] jsons2 = [Json(true), Json(false), Json(42)];
  assert(hasBoolean(jsons2, false) == true);

  // hasBoolean - value not found
  Json[] jsons3 = [Json(true), Json(42), Json("text")];
  assert(hasBoolean(jsons3, false) == false);
  // hasBoolean - empty array
  Json[] jsons4 = [];
  assert(hasBoolean(jsons4, true) == false);

  // hasBoolean - no boolean values in array
  Json[] jsons5 = [Json(42), Json("text"), Json(3.14)];
  assert(hasBoolean(jsons5, true) == false);
  // hasAllBoolean - all values present
  Json[] jsons6 = [Json(true), Json(false), Json(true)];
  assert(hasAllBoolean(jsons6, [true, false]) == true);

  // hasAllBoolean - not all values present
  Json[] jsons7 = [Json(true), Json(42)];
  assert(hasAllBoolean(jsons7, [true, false]) == false);

  // hasAnyBoolean - any value found
  Json[] jsons8 = [Json(true), Json(42), Json("text")];
  assert(hasAnyBoolean(jsons8, [true, false]) == true);

  // hasAnyBoolean - no values found
  Json[] jsons9 = [Json(42), Json("text")];
  assert(hasAnyBoolean(jsons9, [true, false]) == false);
}
// #endregion is
