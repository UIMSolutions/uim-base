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
bool hasAllInteger(Json[] jsons, int[] values) {
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
bool hasAnyInteger(Json[] jsons, int[] values) {
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
bool hasInteger(Json[] jsons, int value) {
  return jsons.any!(json => json.isInteger && json.getInteger == value);
}
///
unittest {
  // basic integer presence
  Json[] jsons = [Json(1), Json(2), Json(42)];
  assert(hasInteger(jsons, 1));
  assert(hasInteger(jsons, 42));
  assert(!hasInteger(jsons, 100));

  // any: at least one present
  assert(hasAnyInteger(jsons, [100, 42, 7]));
  assert(!hasAnyInteger(jsons, [7, 8, 9]));

  // all: every value present
  assert(hasAllInteger(jsons, [1, 2]));
  assert(!hasAllInteger(jsons, [1, 3]));

  // edge cases
  Json[] emptyJsons;
  assert(!hasInteger(emptyJsons, 1));
  assert(!hasAnyInteger(emptyJsons, [1, 2]));
  // hasAllInteger with an empty list of values should return true (vacuous truth)
  assert(hasAllInteger(emptyJsons, []));
}
// #endregion is
