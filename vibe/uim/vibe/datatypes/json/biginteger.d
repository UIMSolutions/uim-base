/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.biginteger;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
mixin(IsJsonFunctions!("BigInteger"));

bool isBigInteger(Json json, bool strict = true) {
  if (!strict) {
    // TODO: Future: Implement a more generic check for big integers.
  }
  return (json.type == Json.Type.bigInt);
}

unittest {
  assert(parseJsonString(`1000000000000000000000`).isBigInteger);
  assert(!parseJsonString(`1`).isBigInteger);
}
// #endregion is