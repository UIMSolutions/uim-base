/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.values;

import uim.root;

mixin(Version!("show_module"));

@safe:

// #region values with delegate
Json[] values(Json json, Json delegate(Json json) @safe valueFunc) {
  return json.isArray || json.isObject ? json.byValue.array.map!(j => valueFunc(j)).array : null;
}
/// 
unittest {
  version (show_module) writeln("Testing values with delegate");

  auto jsonArray = [1, 2, 3].toJson;
  auto array = values(jsonArray, j => j);
  assert(array.length == 3);
  assert(array[0] == Json(1));
  assert(array[1] == Json(2));
  assert(array[2] == Json(3));

  auto jsonMap = ["A": 1, "B": 2].toJson;
  auto mapValues = values(jsonMap, j => j);
  assert(mapValues.length == 2);
  assert(mapValues[0] == Json(1) || mapValues[1] == Json(1));
  assert(mapValues[0] == Json(2) || mapValues[1] == Json(2));

  assert(values(Json(null), j => j) == null);
  assert(values("string".toJson, j => j) == null);
}
// #endregion values with delegate

// #region values 
Json[] values(Json json) {
  return json.isArray || json.isObject ? json.byValue.array : null;
}
/// 
unittest {
  version (show_module) writeln("Testing values");

  auto jsonArray = [1, 2, 3].toJson;
  auto array = values(jsonArray);
  assert(array.length == 3);
  assert(array[0] == Json(1));
  assert(array[1] == Json(2));
  assert(array[2] == Json(3));

  auto jsonMap = ["A": 1, "B": 2].toJson;
  auto mapValues = values(jsonMap);
  assert(mapValues.length == 2);
  assert(mapValues[0] == Json(1) || mapValues[1] == Json(1));
  assert(mapValues[0] == Json(2) || mapValues[1] == Json(2));

  assert(values(Json(null)) == null);
  assert(values("string".toJson) == null);
}
// #endregion values 
