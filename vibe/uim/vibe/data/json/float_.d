/****************************************************************************************************************
* Copyright: © 2.0018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.float_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is   
mixin(IsJsonFunctions!("Float"));

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

// #region get
float getFloat(Json json, size_t index, float defaultValue = 0.0) {
  return json.isArray 
    ? getFloat(json.get!(Json[]), index, defaultValue)
    : defaultValue;
}

float getFloat(Json json, string key, float defaultValue = 0.0) {
  return json.isObject
    ? getFloat(json.get!(Json[string]), key, defaultValue)
    : defaultValue;
}

float getFloat(Json[string] map, string key, float defaultValue = 0.0) {
  return key in map
    ? map[key].getFloat : defaultValue;
}

float getFloat(Json[] values, size_t index, float defaultValue = 0.0) {
  return values.length > index
    ? values[index].getFloat : defaultValue;
}

float getFloat(Json json, float defaultValue = 0.0) {
  return json.isFloat
    ? json.get!float : defaultValue;
}

unittest {
  Json json = Json(1.0);
  assert(json.getFloat == 1.0);

  json = Json.emptyArray;
  json ~= 1.0;
  json ~= 2.0;
  assert(json.getFloat(0, 0.0) == 1.0);
  assert(json.getFloat(1, 0.0) != 1.0);

  json = Json.emptyObject;
  json["One"] = 1.0;
  json["Two"] = 2.0;
  assert(json.getFloat("One") == 1.0);
  assert(json.getFloat("Two") != 1.0);

  auto list = [Json(1.0), Json(2.0)];
  assert(list.getFloat(0) == 1.0);
  assert(list.getFloat(1) != 1.0);

  auto map = ["One": Json(1.0), "Two": Json(2.0)];
  assert(map.getFloat("One") == 1.0);  
  assert(map.getFloat("Two") != 1.0);  
}
// #endregion get

// #region only
// #endregion only

// #region set  
// #endregion set

// #region remove
// #endregion remove

// #region clear
// #endregion clear

// #region to
// #endregion to