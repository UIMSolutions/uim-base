/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.bigintegers.biginteger;

import uim.vibe;
mixin(Version!("test_uim_vibe"));
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
    // Test: Large integer should be recognized as BigInteger
    auto bigIntJson = parseJsonString(`1000000000000000000000`);
    assert(bigIntJson.isBigInteger, "Failed: Large integer not recognized as BigInteger");

    // Test: Small integer should not be recognized as BigInteger
    auto smallIntJson = parseJsonString(`1`);
    assert(!smallIntJson.isBigInteger, "Failed: Small integer incorrectly recognized as BigInteger");

    // Test: Non-integer types should not be recognized as BigInteger
    auto floatJson = parseJsonString(`1.23`);
    assert(!floatJson.isBigInteger, "Failed: Float incorrectly recognized as BigInteger");

    auto stringJson = parseJsonString(`"1000000000000000000000"`);
    assert(!stringJson.isBigInteger, "Failed: String incorrectly recognized as BigInteger");

    auto boolJson = parseJsonString(`true`);
    assert(!boolJson.isBigInteger, "Failed: Boolean incorrectly recognized as BigInteger");

    auto nullJson = parseJsonString(`null`);
    assert(!nullJson.isBigInteger, "Failed: Null incorrectly recognized as BigInteger");
}

// #endregion is