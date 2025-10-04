/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.helpers.json;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

string typeName(Json json) {
  if (json.isNull) {
    return "null";
  }
  if (json.isDouble) {
    return "double";
  }
  if (json.isLong) {
    return "long";
  }
  if (json.isString) {
    return "string";
  }
  if (json.isArray) {
    return "array";
  }
  if (json.isObject) {
    return "object";
  }
  return "unknown";
}
