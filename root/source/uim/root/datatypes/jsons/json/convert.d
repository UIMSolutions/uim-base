/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.convert;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[] toArray(Json value) {
  if (value.isNull) {
    return null;
  }

  return value.isArray
    ? value.to!(Json[]) : null;
}

Json[string] toMap(Json value) {
  if (value.isNull) {
    return null;
  }

  return value.isObject
    ? value.to!(Json[string]) : null;
}

bool toBoolean(Json value, bool defaultValue = false) {
  if (value.isNull) {
    return defaultValue;
  }

  return value.isBoolean
    ? value.to!(bool) : defaultValue;
}

int toInteger(Json value, int defaultValue = 0) {
  if (value.isNull) {
    return defaultValue;
  }

  return value.isInteger
    ? value.to!(int) : defaultValue;
}

double toDouble(Json value, double defaultValue = 0.0) {
  if (value.isNull) {
    return defaultValue;
  }

  return value.isDouble 
    ? value.to!(double) : defaultValue;
}

string toString(Json value, string defaultValue = "") {
  if (value.isNull) {
    return defaultValue;
  }

  return value.isString  
    ? value.to!(string) : defaultValue;
}
