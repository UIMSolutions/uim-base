/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.objects.object_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

// #region is
mixin(IsJsonFunctions!("Object"));

// Check if the JSON value is an object
bool isObject(Json json, bool strict = true) {
  if (!strict) {
    // Future improvement: check for boolean, integer, and string types
  }
  return json.type == Json.Type.object;
}

unittest {
  assert(parseJsonString(`{"a": "b"}`).isObject);
  assert(!parseJsonString(`["a", "b", "c"]`).isObject);

  assert(Json.emptyObject.isObject);
  assert(!Json.emptyArray.isObject);
  assert(!Json(1).isObject);

  Json json = Json.emptyObject;
  json["a"] = Json.emptyObject;
  json["b"] = Json.emptyObject;
  
  assert(json["a"].isObject && json["b"].isObject);
  assert(!json["a"].isArray && !json["b"].isArray);

  assert(json.isObject("a") && json.isObject("b") && !json.isObject("c"));  

  assert(json.isAnyObject(["a", "b"]) && json.isAnyObject(["a", "c"]) && !json.isAnyObject(["c", "d"]));
  assert(json.isAllObject(["a", "b"]) && !json.isAllObject(["a", "c"]));

  // Json[]  
  auto a = Json.emptyObject;
  auto b = Json.emptyObject;
  auto c = Json.emptyArray;
  auto d = Json.emptyArray;
  auto list = [Json.emptyObject, Json.emptyObject];
  assert(list[0].isObject && list[1].isObject);  

  assert(list.isAnyObject);
  assert(list.isAllObject);

  list[0] = Json.emptyArray;
  assert(!list[0].isObject && list[1].isObject);  

  assert(list.isAnyObject);
  assert(!list.isAllObject);

  list[1] = Json.emptyArray;
  assert(!list[0].isObject && !list[1].isObject);  

  assert(!list.isAnyObject);
  assert(!list.isAllObject);
}
// #endregion is

// #region get
Json[string] getObject(Json json) {
  return json.isObject
    ? json.to!(Json[string])
    : null;
}
// #endregion get

// #region only
// #endregion only

// #region to
// #endregion to