/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.booleans.boolean;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

// #region get
mixin(GetJsonValue!("bool", "Boolean", "false"));

bool getBoolean(Json json) {
  return json.isBoolean
    ? json.get!bool : false;
}

unittest {
  Json json = Json(true);
  assert(json.getBoolean);

  json = Json.emptyArray;
  json ~= true;
  json ~= false;
  assert(json.getBooleanAt(0) == true);
  assert(json.getBooleanAt(1) != true);

  json = Json.emptyObject;
  json["One"] = true;
  json["Two"] = false;
  assert(json.getBoolean("One") == true);
  assert(json.getBoolean("Two") != true);

  auto list = [Json(true), Json(false)];
  assert(list.getBooleanAt(0) == true);
  assert(list.getBooleanAt(1) != true);

  auto map = ["One": Json(true), "Two": Json(false)];
  assert(map.getBoolean("One") == true);
  assert(map.getBoolean("Two") != true);
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
