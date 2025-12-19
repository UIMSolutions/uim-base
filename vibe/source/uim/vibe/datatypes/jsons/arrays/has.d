/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.items.arrays.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region all
/** 
Determines if all specified array values are present in the given array of Items.
  
  Params:
    items = The array of Items to check.
    values = The array values to look for.
  
  Returns:
    true if all specified array values are found in the array, false otherwise.
*/
bool hasAllArray(Json[] items, Json[] values) {
  return values.all!(value => items.hasArray(value));
}

// #endregion all

// #region any
/** 
Determines if any of the specified array values are present in the given array of Items.
  
  Params:
    items = The array of Items to check.
    values = The array values to look for.
  
  Returns:
    true if any of the specified array values are found in the array, false otherwise.
*/
bool hasAnyArray(Json[] items, Json[] values) {
  return values.any!(value => items.hasArray(value));
}
///

// #endregion any

// #region is
/** 
Determines if the specified array value is present in the given array of Items.
  
  Params:
    items = The array of Items to check.
    value = The array value to look for.
  
  Returns:
    true if the specified array value is found in the array, false otherwise.
*/
bool hasArray(Json[] items, Json value) {
  if (!value.isArray) {
    return false;
  }
  return items.any!(json => json.isArray && json == value);
}
// #endregion is

bool hasAllKey(Json[] items, string[] keys) {
  return keys.all!(key => hasKey(items, key));
}

bool hasAnyKey(Json[] items, string[] keys) {
  return keys.any!(key => hasKey(items, key));
}

bool hasKey(Json[] items, string key) {
  return items.any!(item => item.hasKey(key));
}
