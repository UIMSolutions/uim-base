/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.integral;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region is
mixin(IsJsonFunctions!("Integral"));

bool isIntegral(Json value, bool strict = true) {
  if (!strict) {
    // Future: Add support for BigInt and other integral types.
  }
  return value.isLong(strict);
}
// #endregion is
