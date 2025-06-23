/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.empty;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region is
mixin(IsJsonFunctions!("Empty"));

bool isEmpty(Json value, bool strict = true) {
  if (!strict) {
    // Furure: Add support for empty boolean, integer, float, and string.
  }
  
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
// #endregion is

