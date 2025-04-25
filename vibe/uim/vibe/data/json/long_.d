/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.long_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
// Check if the Json value is a long integer.
mixin(CheckJsonIs!("Long"));

bool isLong(Json value, bool strict = true) {
  if (!strict) {
    // TODO: Future: Implement a more generic check for long integers.
  }
  
  return (value.type == Json.Type.int_);
}
unittest {
  assert(!Json(true).isLong);  
  assert(Json(10).isLong);  
  assert(!Json(1.1).isLong);  
  assert(!Json("text").isLong);
}
// #endregion is