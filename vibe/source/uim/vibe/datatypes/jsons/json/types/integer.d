/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.integer;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool allInteger(Json json, string[][] paths) {
  return paths.any!(path => json.isInteger(path));
}

bool allInteger(Json json, string[] keys) {
  return keys.any!(key => json.isInteger(key));
}

bool anyInteger(Json json, string[][] paths) {
  return paths.any!(path => json.isInteger(path));
}

bool anyInteger(Json json, string[] keys) {
  return keys.any!(key => json.isInteger(key));
}

bool isInteger(Json json, string[] path) {
  if (!json.hasPath(path)) {
    return false;
  }

  if (path.length == 1) {
    return json.isInteger(path[0]);
  }

  return json[path[0]].isInteger(path[1 .. $]);
}

bool isInteger(Json json, string key) {
  return json.hasKey(key) && json[key].isInteger;
}
/// 
unittest {
  assert(!Json(true).isInteger);
  assert(Json(10).isInteger);
  assert(!Json(1.1).isInteger);
  assert(!Json("text").isInteger);

  Json map = Json.emptyObject;
  map["a"] = Json(1);
  map["b"] = Json(2);
  map["c"] = Json(3.0);

  assert(map.isInteger("a") && map.isInteger("b"));
  assert(!map.isInteger("c"));

  assert(map.allInteger(["a", "b"]));
  assert(map.anyInteger(["a", "b"]));

  map["b"] = Json("B");
  assert(map.isInteger("a"));
  assert(!map.isInteger("b") && !map.isInteger("c"));

  assert(!map.allInteger(["a", "b"]));
  assert(map.anyInteger(["a", "b"]));

  map["a"] = Json("A");
  assert(!map.isInteger("a") && !map.isInteger("b") && !map.isInteger("c"));

  assert(!map.allInteger(["a", "b"]));
  assert(!map.anyInteger(["a", "b"]));

  // Json[]
  auto list = [Json(1), Json(2)];
  assert(list[0].isInteger && list[1].isInteger);

  assert(list.allInteger);
  assert(list.anyInteger);

  list[1] = Json(2.0);
  assert(list[0].isInteger && !list[1].isInteger);

  assert(!list.allInteger);
  assert(list.anyInteger);

  list[0] = Json(1.0);
  assert(!list[0].isInteger && !list[1].isInteger);
  assert(!list.allInteger);
  assert(!list.anyInteger);
}

bool isInteger(Json value) {
  return (value.type == Json.Type.int_);
}

