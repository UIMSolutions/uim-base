/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.float_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is   
mixin(CheckJsonIs!("Float"));

bool isFloat(Json value, bool strict = true) {
  if (!strict) {  
    // TODO: Future: Implement a more generic check for float values.
  }
  return (value.type == Json.Type.float_);
}

unittest {
  auto json = Json(1.1);
  assert(json.isFloat);
  assert(!json.isInteger);

}
// #region is   
