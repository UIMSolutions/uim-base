/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject get the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] getArray(Json value) {
  if (value.isNull) {
    return null;
  }

  return value.isArray
    ? value.get!(Json[]) : null;
}

Json[string] getMap(Json value) {
  if (value.isNull) {
    return null;
  }

  return value.isObject
    ? value.get!(Json[string]) : null;
}

bool getBoolean(Json value, bool defaultValue = false) {
  if (value.isNull) {
    return defaultValue;
  }

  return value.isBoolean
    ? value.get!(bool) : defaultValue;
}

int getInteger(Json value, int defaultValue = 0) {
  if (value.isNull) {
    return defaultValue;
  }

  return value.isInteger
    ? value.get!(int) : defaultValue;
}

double getDouble(Json value, double defaultValue = 0.0) {
  if (value.isNull) {
    return defaultValue;
  }

  return value.isDouble 
    ? value.get!(double) : defaultValue;
}

string getString(Json value) {
  if (value.isNull) {
    return "";
  }

  return value.isString  
    ? value.get!(string) : "";
}
