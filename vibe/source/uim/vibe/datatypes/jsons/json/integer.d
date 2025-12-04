/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.integer;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region is
// #region isInteger(Json)
bool allInteger(Json json) {
  if (json.isObject) {
    return allInteger(json.to!(Json[string]));
  }
  if (json.isArray) {
    return allInteger(json.to!(Json[]));
  }
  return json.isInteger;
}

bool allInteger(Json json, string[][] paths) {
  return paths.all!(path => json.isInteger(path));
}

bool allInteger(Json json, string[] keys) {
  return keys.all!(key => json.isInteger(key));
}

bool anyInteger(Json json) {
  if (json.isObject) {
    return anyInteger(json.to!(Json[string]));
  }
  if (json.isArray) {
    return anyInteger(json.to!(Json[]));
  }
  return json.isInteger;
}



// #region get
mixin(GetJsonValue!("int", "Integer", "0"));

int getInteger(Json json) {
  return json.isInteger
    ? json.get!int : 0;
}
/// 
unittest {
  Json json = Json(1);
  assert(json.getInteger == 1);

  json = Json.emptyArray;
  json ~= 1;
  json ~= 2;
  assert(json.getIntegerAt(0) == 1);
  assert(json.getIntegerAt(1) != 1);

  json = Json.emptyObject;
  json["One"] = 1;
  json["Two"] = 2;
  assert(json.getInteger("One") == 1);
  assert(json.getInteger("Two") != 1);

  auto list = [Json(1), Json(2)];
  assert(list.getIntegerAt(0) == 1);
  assert(list.getIntegerAt(1) != 1);

  auto map = ["One": Json(1), "Two": Json(2)];
  assert(map.getInteger("One") == 1);
  assert(map.getInteger("Two") != 1);
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
