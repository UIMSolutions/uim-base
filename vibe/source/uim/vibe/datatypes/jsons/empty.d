/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.json.empty;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

// #region is
mixin(IsJsonFunctions!("Empty"));

/// Check if the Json value is empty (null, empty string, empty array, or empty object).
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

unittest {
  /* { // Test null value
    Json json;
    assert(json.isEmpty);
    assert(json.isEmpty(true));
    assert(json.isEmpty(false));
  } */

  { // Test null value
    Json json = Json(null);
    assert(json.isEmpty);
    assert(json.isEmpty(true));
    assert(json.isEmpty(false));
  }

  { // Test empty string
    Json jstr = Json("");
    assert(isEmpty(jstr));
    assert(isEmpty(jstr, true));
    assert(isEmpty(jstr, false));
  }

  { // Test non-empty string
    Json jstr2 = Json("abc");
    assert(!isEmpty(jstr2));
    assert(!isEmpty(jstr2, true));
    assert(!isEmpty(jstr2, false));
  }

  { // Test empty array
    Json jarr = Json.emptyArray;
    assert(isEmpty(jarr));
    assert(isEmpty(jarr, true));
    assert(isEmpty(jarr, false));
  }

  { // Test non-empty array
    Json jarray2 = Json([Json(1), Json(2)]);
    assert(!isEmpty(jarray2));
    assert(!isEmpty(jarray2, true));
    assert(!isEmpty(jarray2, false));
  }

  { // Test empty object
    Json json = Json.emptyObject;
    assert(json.isEmpty);
    assert(json.isEmpty(true));
    assert(json.isEmpty(false));
  }

  { // Test non-empty object
    Json json = Json.emptyObject;
    json["a"] = Json(1);
    assert(!json.isEmpty);
    assert(!json.isEmpty(true));
    assert(!json.isEmpty(false));
  }

  { // Test boolean (should be false)
    Json jbool = Json(true);
    assert(!isEmpty(jbool));
    assert(!isEmpty(jbool, true));
    assert(!isEmpty(jbool, false));
  }

  { // Test number (should be false)
    Json jint = Json(0);
    assert(!isEmpty(jint));
    assert(!isEmpty(jint, true));
    assert(!isEmpty(jint, false));
  }
}
// #endregion is
