/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.doubles.remove;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

/** 
  * Remove double Json values from the specified array of Json values based on a delegate function.
  *
  * Params:
  *   items = The array of Json values to remove double values from.
  *   removeFunc = A delegate function that takes a Json value and returns true if it should be removed.
  *
  * Returns:
  *   A new array of Json values with the specified double values removed.
  */
Json[] removeDoubles(Json[] items, bool delegate(Json json) @safe removeFunc) {
  return items.filter!(json => !foundDouble(json, removeFunc)).array;
}

/** 
  * Remove double Json values from the specified array of Json values based on their indices.
  *
  * Params:
  *   items = The array of Json values to remove double values from.
  *   indices = An array of indices specifying which double values to remove.
  *
  * Returns:
  *   A new array of Json values with the specified double values removed.
  */
Json[] removeDoubles(Json[] items, size_t[] indices) {
  return items.removeValues(indices).removeDoubles;
}

Json[] removeDoubles(Json[] items) {
  return items.filter!(item => !item.isDouble).array;
}

protected bool foundDouble(Json json, bool delegate(Json value) @safe removeFunc) {
  bool found = false;
  () @trusted { found = json.isDouble && removeFunc(json); }();
  return found;
}