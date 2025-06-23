/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.scalar;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region is
mixin(IsJsonFunctions!("Scalar"));

bool isScalar(Json value, bool strict = true) {
  if (!strict) {
    if (value.isBoolean) {
      return true;
    }
    if (value.isInteger) {
      return true;
    }

    if (value.isDouble) {
      return true;
    }
    
    if (value.isString) {
      return true;
    }
  }
  return !value.isArray && !value.isObject;
}
// #endregion is
