/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.long_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
// Check if the Json value is a long integer.
mixin(CheckJsonIs!("Long"));

bool isLong(Json value, bool strict = true) {
  if (!strict) {
    // TODO: Future: Implement a more generic check for long integers.
  }
  
  return (value.type == Json.Type.int_);
}
unittest { // Json
  assert(!Json(true).isLong);  
  assert(Json(10).isLong);  
  assert(!Json(1.1).isLong);  
  assert(!Json("text").isLong);
}

unittest { // Json[]
  auto a = Json(1);
  auto b = Json(2);
  auto c = Json("1");
  auto d = Json(1.1);
  auto list = [a, b, c, d];
  assert([a, b].isAllLong);
  assert(![a, c].isAllLong);

  assert(list.isAllLong([0, 1]));
  assert(!list.isAllLong([2, 3]));

  assert([a, b].isAnyLong);
  assert([a, c].isAnyLong);
  assert(![c, d].isAnyLong);

  assert(list.isAnyLong([0, 1]));
  assert(list.isAnyLong([1, 2]));
  assert(!list.isAnyLong([2, 3]));
}

unittest { // Json[string]
  auto a = Json(1);
  auto b = Json(2);
  auto c = Json("1");
  auto d = Json(1.1);
  auto map = ["A": a, "B": b, "C": c, "D": d];
  assert(["A": a, "B": b].isAllLong);
  assert(!["A": a, "C": c].isAllLong);

  assert(map.isAllLong(["A", "B"]));
  assert(map.isAllLong(["A", "C"]));

  assert(["A": a, "B": b].isAnyLong);
  assert(["A": a, "C": c].isAnyLong);
  assert(!["C": c, "D": d].isAnyLong);

  assert(map.isAnyLong(["A", "B"]));
  assert(map.isAnyLong(["A", "C"]));
  assert(map.isAnyLong(["C", "D"]));
}
// #endregion is