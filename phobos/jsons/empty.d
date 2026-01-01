/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.empty;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region is

/** 
  * Checks whether the given Json value is empty.
  * 
  * A Json value is considered empty if it is:
  * - Null
  * - An empty string
  * - An empty array
  * - An empty object
  * 
  * Params:
  *   value = The Json value to check.
  * 
  * Returns:
  *   true if the Json value is empty, false otherwise.
  */
bool isEmpty(Json value) {
  if (value.isNull) {
    return true;
  }

  if (value.isString) {
    return value.getString.length == 0;
  }

  if (value.isArray) {
    return value.getArray.length == 0;
  }

  if (value.isObject) {
    return value.getObject.length == 0;
  }

  return false;
}

unittest {
  assert(Json(null).isEmpty);
  assert("".toJson.isEmpty);
  assert(![123].toJson.isEmpty);
  assert(!true.toJson.isEmpty);
  assert(!123.toJson.isEmpty);
}
// #endregion is
