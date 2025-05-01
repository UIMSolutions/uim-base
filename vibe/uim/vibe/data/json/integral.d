/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.integral;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
mixin(CheckJsonIs!("Integral"));

bool isIntegral(Json value, bool strict = true) {
  if (!strict) {
    // Future: Add support for BigInt and other integral types.
  }
  return value.isLong(strict);
}
// #endregion is
