/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.object_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
mixin(CheckJsonIs!("Object"));

bool isObject(Json value, string key) {
  return value.hasKey(key) 
    ? value[key].isObject
    : false;
}

bool isObject(Json json) {
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

  assert(json.anyObject(["a", "b"]) && json.anyObject(["a", "c"]) && !json.anyObject(["c", "d"]));
  assert(json.anyObject("a", "b") && json.anyObject("a", "c") && !json.anyObject("c", "d"));
  
  assert(json.allObject(["a", "b"]) && !json.allObject(["a", "c"]));
  assert(json.allObject("a", "b") && !json.allObject("a", "c"));

  auto a = Json.emptyObject;
  auto b = Json.emptyObject;
  auto c = Json.emptyArray;
  auto d = Json.emptyArray;

  assert(a.isObject && b.isObject && !c.isObject && !d.isObject);  

  assert(json.anyObject([a, b]) && json.anyObject([a, c]) && !json.anyObject([c, d]));
  assert(json.anyObject(a, b) && json.anyObject(a, c) && !json.anyObject(c, d));

  assert(json.allObject([a, b]) && !json.allObject([a, c]));
  assert(json.allObject(a, b) && !json.allObject(a, c));
}
// #endregion is

// #region get
// #endregion get

// #region only
// #endregion only