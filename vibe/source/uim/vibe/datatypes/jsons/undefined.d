/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.undefined;

import uim.vibe;
mixin(Version!("test_uim_vibe"));
@safe:

// #region is
mixin(IsJsonFunctions!("Undefined"));

bool isUndefined(Json value, bool strict = true) {
  if (!strict) {
    // Future: Add support for undefined boolean, integer, float, and string.
  }
  return (value.type == Json.Type.undefined);
}

unittest {
/*   auto json = Json(undefined);
  assert(json.isUndefined);
  assert(!json.isInteger);
  assert(!json.isFloat);
  assert(!json.isString);
  assert(!json.isBoolean);
  assert(!json.isArray);
  assert(!json.isObject); */
}
// #endregion is