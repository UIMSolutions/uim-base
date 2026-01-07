/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.arrays.remove;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
// #region indices
Json[] removeArrays(Json[] jsons, size_t[] indices, bool delegate(size_t) @safe removeFunc) {
  return jsons.removeIndices(indices, (size_t index) => jsons[index].isArray && removeFunc(index));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[] jsons, size_t[] indices, bool delegate(size_t) @safe removeFunc)");

  Json[] jsons = [
    [1, 2].toJson, Json("string"), [3, 4].toJson, Json(true), [5, 6].toJson
  ];

  Json[] result;
  foreach (index, value; jsons) {
    writeln("index: ", index, ", value: ", value, ", condition: ", !([0, 2].hasValue(index)) || !(index % 2 == 0), " part1: ", [0, 2].hasValue(index), ", part2: ", index % 2 == 0, " mod _= ", index % 2);
    if (!([0, 2].hasValue(index)) || !(index % 2 == 0)) {
      result ~= value;
    }
  }

  // Json[] result = removeArrays(jsons, [0, 2], (size_t index) => index % 2 == 0);
  writeln("result: ", result);
  assert(result.length == 3);
  assert(result.filterArrays.length == 1);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}

Json[] removeArrays(Json[] jsons, size_t[] indices) {
  return jsons.removeIndices(indices, (index) => jsons[index].isArray);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[] jsons, size_t[] indices)");

  Json[] jsons = [
    [1, 2].toJson, Json("string"), [3, 4].toJson, Json(true), [5, 6].toJson
  ];
  Json[] result = removeArrays(jsons, [0, 2]);
  writeln("result: ", result);
  assert(result.length == 3);
  assert(result.filterArrays.length == 1);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}

Json[] removeArrays(Json[] jsons, bool delegate(size_t) @safe removeFunc) {
  return jsons.removeIndices((size_t index) => jsons[index].isArray && removeFunc(index));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[] jsons, bool delegate(size_t) @safe removeFunc)");

  Json[] jsons = [
    [1, 2].toJson, Json("string"), [3, 4].toJson, Json(true), [5, 6].toJson
  ];
  Json[] result = removeArrays(jsons, (size_t index) => index % 2 == 0);
  assert(result.length == 2);
  assert(result.filterArrays.length == 0);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}
// #endregion indices

// #region values
Json[] removeArrays(Json[] jsons, Json[] values, bool delegate(Json) @safe removeFunc) {
  return jsons.removeValues(values, (Json json) => json.isArray && removeFunc(json));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[] jsons, Json[] values, bool delegate(Json) @safe removeFunc)");

  Json[] jsons = [
    [1, 2].toJson, Json("string"), [3, 4].toJson, Json(true), [5, 6].toJson
  ];
  Json[] toRemove = [Json("string"), [3, 4].toJson];
  Json[] result = removeArrays(jsons, toRemove, (Json json) => json.isString);
  writeln("result: ", result);
  assert(result.length == 5);
  assert(result.filterArrays.length == 3);
  assert(result.filterBooleans.length == 1);
}

Json[] removeArrays(Json[] jsons, bool delegate(Json) @safe removeFunc) {
  return jsons.removeValues((Json json) => json.isArray && removeFunc(json));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[] jsons, bool delegate(Json) @safe removeFunc)");

  Json[] jsons = [
    [1, 2].toJson, Json("string"), [3, 4].toJson, Json(true), [5, 6].toJson
  ];
  Json[] result = removeArrays(jsons, (Json json) => json.isString);
  assert(result.length == 4);
  assert(result.filterArrays.length == 3);
  assert(result.filterBooleans.length == 1);
}

Json[] removeArrays(Json[] jsons, Json[] values) {
  return jsons.removeValues(values, (Json json) => json.isArray);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[] jsons, Json[] values)");

  Json[] jsons = [
    [1, 2].toJson, Json("string"), [3, 4].toJson, Json(true), [5, 6].toJson
  ];
  Json[] toRemove = [[1, 2].toJson, [5, 6].toJson];
  Json[] result = removeArrays(jsons, toRemove);
  assert(result.length == 3);
  assert(result.filterArrays.length == 1);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}
// #endregion values

// #region base
Json[] removeArrays(Json[] jsons) {
  return jsons.removeValues((Json json) => json.isArray);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[] jsons)");

  Json[] jsons = [
    [1, 2].toJson, Json("string"), [3, 4].toJson, Json(true), [5, 6].toJson
  ];
  Json[] result = removeArrays(jsons);
  assert(result.length == 2);
  assert(result.filterArrays.length == 0);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}
// #endregion base
// #endregion Json[]

// #region Json[string]
// #region keys
Json[string] removeArrays(Json[string] map, string[] keys, bool delegate(string) @safe removeFunc) {
  return map.removeKeys(keys, (string key) => map[key].isArray && removeFunc(key));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[string] map, string[] keys, bool delegate(string) @safe removeFunc)");

  Json[string] map = [
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ];
  Json[string] result = removeArrays(map);
  assert(result.length == 2);
  assert(result.filterArrays.length == 0);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}

Json[string] removeArrays(Json[string] map, string[] keys) {
  return map.removeKeys(keys, (string key) => map.getValue(key).isArray);
} 
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[string] map, string[] keys)");

  Json[string] map = [
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ];
  Json[string] result = removeArrays(map, ["a", "c"]);
  assert(result.length == 3);
  assert(result.filterArrays.length == 1);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}

Json[string] removeArrays(Json[string] map, bool delegate(string) @safe removeFunc) {
  return map.removeKeys((string key) => map[key].isArray && removeFunc(key));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[string] map, bool delegate(string) @safe removeFunc)");

  Json[string] map = [
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ];
  Json[string] result = removeArrays(map, (string key) => key == "a" || key == "c");
  assert(result.length == 2);
  assert(result.filterArrays.length == 0);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}
// #endregion keys

// #region values
Json[string] removeArrays(Json[string] map, Json[] values, bool delegate(Json) @safe removeFunc) {
  return map.removeValues(values, (Json json) => json.isArray && removeFunc(json));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[string] map, Json[] values, bool delegate(Json) @safe removeFunc)");

  Json[string] map = [
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ];
  Json[] toRemove = [Json("string"), [3, 4].toJson];
  Json[string] result = removeArrays(map, toRemove);
  assert(result.length == 3);
  assert(result.filterArrays.length == 2);
  assert(result.filterBooleans.length == 1);
}

Json[string] removeArrays(Json[string] map, Json[] values) {
  return map.removeValues(values, (Json json) => json.isArray);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[string] map, Json[] values)");

  Json[string] map = [
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ];
  Json[] toRemove = [[1, 2].toJson, [5, 6].toJson];
  Json[string] result = removeArrays(map, toRemove);
  assert(result.length == 3);
  assert(result.filterArrays.length == 1);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}

Json[string] removeArrays(Json[string] map, bool delegate(Json) @safe removeFunc) {
  return map.removeValues((Json json) => json.isArray && removeFunc(json));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[string] map, bool delegate(Json) @safe removeFunc)");

  Json[string] map = [
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ];
  Json[string] result = removeArrays(map, (Json json) => json.isString);
  assert(result.length == 4);
  assert(result.filterArrays.length == 3);
  assert(result.filterBooleans.length == 1);
}
// #endregion values

// #region base
Json[string] removeArrays(Json[string] map) {
  return map.removeValues((Json json) => json.isArray);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json[string] map)");

  Json[string] map = [
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ];
  Json[string] result = removeArrays(map);
  assert(result.length == 2);
  assert(result.filterArrays.length == 0);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}
// #endregion base
// #endregion Json[string]

// #region Json
// #region indices
Json removeArrays(Json json, size_t[] indices, bool delegate(size_t) @safe removeFunc) {
  return json.removeIndices(indices, (size_t index) => json.getValue(index).isArray && removeFunc(index));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json json, size_t[] indices, bool delegate(size_t) @safe removeFunc)");

  Json json = Json([
    [1, 2].toJson, Json("string"), [3, 4].toJson, Json(true), [5, 6].toJson
  ]);
  Json result = removeArrays(json);
  assert(result.length == 2);
  assert(result.getArrays.filterArrays.length == 0);
  assert(result.getArrays.filterStrings.length == 1);
  assert(result.getArrays.filterBooleans.length == 1);
}

Json removeArrays(Json json, bool delegate(size_t) @safe removeFunc) {
  return json.removeIndices((size_t index) => json.getValue(index).isArray && removeFunc(index));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json json, bool delegate(size_t) @safe removeFunc)");

  Json json = Json([
    [1, 2].toJson, Json("string"), [3, 4].toJson, Json(true), [5, 6].toJson
  ]);
  Json result = removeArrays(json, (size_t index) => index % 2 == 0);
  assert(result.getArrays.length == 2);
  assert(result.getArrays.filterArrays.length == 0);
  assert(result.getArrays.filterStrings.length == 1);
  assert(result.getArrays.filterBooleans.length == 1);
}

Json removeArrays(Json json, size_t[] indices) {
  return json.removeIndices(indices, (size_t index) => json.getValue(index).isArray);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json json, size_t[] indices)");

  Json json = Json([
    [1, 2].toJson, Json("string"), [3, 4].toJson, Json(true), [5, 6].toJson
  ]);
  Json result = removeArrays(json, [0, 2]);
  assert(result.getArrays.length == 3);
  assert(result.getArrays.filterArrays.length == 1);
  assert(result.getArrays.filterStrings.length == 1);
  assert(result.getArrays.filterBooleans.length == 1);
}
// #endregion indices

// #region keys
Json removeArrays(Json json, string[] keys, bool delegate(string) @safe removeFunc) {
    return json.removeKeys(keys, (string key) => json.getValue(key).isArray && removeFunc(key));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json json, string[] keys, bool delegate(string) @safe removeFunc)");

  Json json = Json([
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ]);
  Json result = removeArrays(json);
  assert(result.length == 2);
  assert(result.filterArrays.length == 0);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}

Json removeArrays(Json json, string[] keys) {
  return json.removeKeys(keys, (string key) => json.getValue(key).isArray);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json json, string[] keys)");

  Json json = Json([
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ]);
  Json result = removeArrays(json, ["a", "c"]);
  assert(result.length == 3);
  assert(result.filterArrays.length == 1);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}

Json removeArrays(Json json, bool delegate(string) @safe removeFunc) {
  return json.removeKeys((string key) => json.getValue(key).isArray && removeFunc(key)) ;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json json, bool delegate(string) @safe removeFunc)");

  Json json = Json([
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ]);
  Json result = removeArrays(json, (string key) => key == "a" || key == "c");
  assert(result.length == 2);
  assert(result.filterArrays.length == 0);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}
// #endregion keys

// #region values
Json removeArrays(Json json, Json[] values, bool delegate(Json) @safe removeFunc) {
  return json.removeValues(values, (Json j) => j.isArray && removeFunc(j));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json json, Json[] values, bool delegate(Json) @safe removeFunc)");

  Json json = Json([
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ]);
  Json[] toRemove = [Json("string"), [3, 4].toJson];
  Json result = removeArrays(json, toRemove);
  assert(result.length == 3);
  assert(result.getArrays.length == 2);
  assert(result.getBooleans.length == 1);
}

Json removeArrays(Json json, Json[] values) {
  return json.removeValues(values, (Json j) => j.isArray);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json json, Json[] values)");

  Json json = Json([
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ]);
  Json[] toRemove = [[1, 2].toJson, [5, 6].toJson];
  Json result = removeArrays(json, toRemove);
  assert(result.length == 3);
  assert(result.filterArrays.length == 1);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}

Json removeArrays(Json json, bool delegate(Json) @safe removeFunc) {
  return json.removeValues((Json j) => j.isArray && removeFunc(j));
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json json, bool delegate(Json) @safe removeFunc)");

  Json json = Json([
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ]);
  Json result = removeArrays(json, (Json json) => json.isString);
  assert(result.length == 4);
  assert(result.filterArrays.length == 3);
  assert(result.filterBooleans.length == 1);
}
// #endregion values

// #region base
Json removeArrays(Json json) {
  return json.removeValues((Json j) => j.isArray);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeArrays(Json json)");

  Json json = Json([
    "a": [1, 2].toJson,
    "b": Json("string"),
    "c": [3, 4].toJson,
    "d": Json(true),
    "e": [5, 6].toJson
  ]);
  Json result = removeArrays(json);
  assert(result.length == 2);
  assert(result.filterArrays.length == 0);
  assert(result.filterStrings.length == 1);
  assert(result.filterBooleans.length == 1);
}
// #endregion base
// #endregion Json
