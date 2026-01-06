/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.arrays.get;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
Json getArray(Json[] jsons, size_t index, Json defaultValue = Json(null)) {
  return jsons.getValue(index).isArray() ? jsons[index] : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getArray for Json[] with index");

  Json[] jsons = [[1, 2].toJson, ["a": 1].toJson, [3, 4].toJson];
  assert(jsons.getArray(0) == [1, 2].toJson);
  assert(jsons.getArray(1, Json("default")) == Json("default"));
  assert(jsons.getArray(2) == [3, 4].toJson);
}
// #endregion Json[]

// #region Json[string]
Json getArray(Json[string] map, string[] path, Json defaultValue = Json(null)) {
  return map.getValue(path).isArray ? map.getValue(path) : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getArray for Json[string] with path");

  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson
  ];
  assert(map.getArray("first") == [1, 2].toJson);
  assert(map.getArray("second", Json("default")) == Json("default"));
  assert(map.getArray("third") == [3, 4].toJson);
}

Json getArray(Json[string] map, string key, Json defaultValue = Json(null)) {
  return map.getValue(key).isArray ? map.getValue(key) : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getArray for Json[string] with key");

  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson
  ];
  assert(map.getArray("first") == [1, 2].toJson);
  assert(map.getArray("second", Json("default")) == Json("default"));
  assert(map.getArray("third") == [3, 4].toJson);
}
// #endregion Json[string]

// #region Json
Json getArray(Json json, size_t index, Json defaultValue = Json(null)) {
  return json.isArray(index) ? json.getValue(index) : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getArray with index");

  Json json = [ [1, 2].toJson, ["a": 1].toJson, [3, 4].toJson ].toJson;
  assert(json.getArray(0) == [1, 2].toJson);
  assert(json.getArray(1, Json("default")) == Json("default"));
  assert(json.getArray(2) == [3, 4].toJson);
}

Json getArray(Json json, string[] path, Json defaultValue = Json(null)) {
  return json.isArray(path) ? json.getValue(path) : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getArray with path");

  Json json = parseJsonString(`{"data": { "test": [ [1, 2], {"a": 1}, [3, 4] ]}}`);
  assert(json.getArray(["data", "test"])[0] == [1, 2].toJson);
  assert(json.getArray(["data", "test"]).filterArrays()[0] == [1, 2].toJson);
}

Json getArray(Json json, string key, Json defaultValue = Json(null)) {
  return json.isArray(key) ? json.getValue(key) : defaultValue;
}
/// 
unittest {
  Json json = parseJsonString(`{"data": [ [1, 2], {"a": 1}, [3, 4] ]}`);
  assert(json.getArray("data") == [
      [1, 2].toJson, ["a": 1].toJson, [3, 4].toJson
    ].toJson);
  assert(json.getArray("nonexistent", Json("default")) == Json("default"));
}
// #endregion Json
