/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.containers.map_;

import uim.core;

mixin(Version!("test_uim_core"));
@safe:

/* // #region renameKey
unittest {
  auto jsonMap = ["a": Json(1), "b": Json(2), "c": Json(3), "d": Json(4)];
  assert(jsonMap.hasAllKeys(["a", "b", "c", "d"]));
  jsonMap.renameKey("a", "x");
  assert(jsonMap.hasAllKeys(["x", "b", "c", "d"]) && !jsonMap.hasKey("a"));

  jsonMap = ["a": Json(1), "b": Json(2), "c": Json(3), "d": Json(4)];
  assert(jsonMap.hasAllKeys(["a", "b", "c", "d"]));
  jsonMap.renameKeys(["a", "b"], ["x", "y", "z"]); // keys.length < others.length
  assert(jsonMap.hasAllKeys(["x", "y", "c", "d"]) && !jsonMap.hasAnyKey([
      "a", "b"
    ]));

  jsonMap = ["a": Json(1), "b": Json(2), "c": Json(3), "d": Json(4)];
  assert(jsonMap.hasAllKeys(["a", "b", "c", "d"]));
  jsonMap.renameKeys(["a", "b", "c"], ["x", "y"]); // keys.length > others.length
  assert(jsonMap.hasAllKeys(["x", "y", "c", "d"]) && !jsonMap.hasAnyKey([
      "a", "b"
    ]));

  jsonMap = ["a": Json(1), "b": Json(2), "c": Json(3), "d": Json(4)];
  assert(jsonMap.hasAllKeys(["a", "b", "c", "d"]));
  jsonMap.renameKeys(["a": "x", "b": "y"]);
  assert(jsonMap.hasAllKeys(["x", "y", "c", "d"]) && !jsonMap.hasAnyKey([
      "a", "b"
    ]));
}
// #endregion renameKey

// #region set
unittest {
  Json[string] map3 = new Json[string];
  map3.set("1", Json("1"));
  assert(map3.length == 1 && map3.hasKey("1") && map3["1"] == Json("1"));
  map3.set("1", Json("2"));
  assert(map3.length == 1 && map3.hasKey("1") && map3["1"] == Json("2"));
  map3.set("1", 3);
  assert(map3.length == 1 && map3.hasKey("1") && map3["1"] == Json(3));
}
// #endregion set
 */
/* // #region hasValue
unittest {
  Json[string] test2 = ["a": Json("A"), "b": Json("B"), "c": Json("C")];
  assert(test2.hasValue(Json("A")));

  assert(test2.hasAnyValue([Json("A"), Json("B"), Json("C")]));
  assert(test2.hasAnyValue([Json("A"), Json("y"), Json("C")]));
  assert(!test2.hasAnyValue([Json("x"), Json("y"), Json("z")]));

  assert(test2.hasAllValues([Json("A"), Json("B"), Json("C")]));
  assert(!test2.hasAllValues([Json("A"), Json("X"), Json("C")]));
}
// #endregion hasValue */