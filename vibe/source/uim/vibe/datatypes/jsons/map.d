/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.map;

import uim.vibe;
mixin(Version!("test_uim_vibe"));
@safe:

// #region set
// #region set multi
/* unittest {
  Json json = Json.emptyObject;
  json.set([
    "A", Json("a"),
    "B", Json("b"),
    "C", Json("c"),
    ]);
  assert(json["A"] == Json("a") && json["B"] == Json("b") && json["C"] == Json("c"));

  json = Json.emptyObject;
  json.set([
    "A", "a",
    "B", "b",
    "C", "c",
    ]);
  assert(json["A"] == Json("a") && json["B"] == Json("b") && json["C"] == Json("c"));

  json = Json.emptyObject;
  json.set(["A", "B", "C"], Json("x"));
  assert(json["A"] == Json("x") && json["B"] == Json("x") && json["C"] == Json("x"));

  json = Json.emptyObject;
  json.set(["A", "B", "C"], "x");
  assert(json["A"] == Json("x") && json["B"] == Json("x") && json["C"] == Json("x"));
}
 */// #endregion set multi
/* unittest {
  Json map = Json.emptyObject;
  map["a"] = "A";
  map["b"] = "B";
  map["c"] = "C";
  assert(map.length == 3);

  map.set("d", Json("x"));
  assert(map.length == 4 && map.hasKey("d"));

  map.set("e", Json("x")).set("f", Json("x"));
  assert(map.length == 6 && map.hasAllKey(["d", "e", "f"]));

  map = Json.emptyObject;
  map["a"] = "A";
  map["b"] = "B";
  map["c"] = "C";
  map.set(["d", "e", "f"], Json("x"));
  assert(map.length == 6 && map.hasKey("d") && map["f"] == Json("x"));

  map = Json.emptyObject;
  map["a"] = "A";
  map["b"] = "B";
  map["c"] = "C";
  map.set("d", Json("x")).set("e", Json("x")).set("f", Json("x"));
  assert(map.length == 6 && map.hasKey("d") && map["f"] == Json("x"));

  map = Json.emptyObject;
  map["a"] = "A";
  map["b"] = "B";
  map["c"] = "C";
  map.set(["d": Json("x"), "e": Json("x"), "f": Json("x")]);
  assert(map.length == 6 && map.hasKey("d") && map["f"] == Json("x"));
} */
// #region set Json
