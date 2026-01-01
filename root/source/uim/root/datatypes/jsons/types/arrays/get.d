module uim.root.datatypes.jsons.types.arrays.get;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
Json[] getArrays(Json[] jsons, size_t[] indices) {
  return indices.filter!(index => jsons.isArray(index))
    .map!(index => jsons.getArray(index))
    .array;
}
/// 
unittest {
  Json[] jsons = [[1, 2].toJson, ["a": 1].toJson, [3, 4].toJson];
  auto arrays = jsons.getArrays([0, 1, 2, 3]);
  assert(arrays.length == 2);

  assert(arrays[0].isArray);
  assert(arrays[1].isArray);

  assert(arrays[0] == [1, 2].toJson);
  assert(arrays[1] == [3, 4].toJson);

  Json json2 = parseJsonString(`[ [1, 2], {"a": 1}, [3, 4] ]`);
  auto arrays2 = json2.getArrays([0, 1, 2, 3]);
  assert(arrays2.length == 2);
}

Json getArray(Json[] jsons, size_t index, Json defaultValue = null) {
  return jsons.getValue(index).isArray() ? jsons[index] : defaultValue;
}
/// 
unittest {
  Json[] jsons = [[1, 2].toJson, ["a": 1].toJson, [3, 4].toJson];
  assert(jsons.getArray(0) == [1, 2].toJson);
  assert(jsons.getArray(1, Json("default")) == Json("default"));
  assert(jsons.getArray(2) == [3, 4].toJson);
}
// #endregion Json[]

// #region Json[string]
Json getArray(Json[string] map, string[] path, Json defaultValue = null) {
  return map.getValue(path).isArray ? map.getValue(path) : defaultValue;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson
  ];
  assert(map.getArray("first") == [1, 2].toJson);
  assert(map.getArray("second", Json("default")) == Json("default"));
  assert(map.getArray("third") == [3, 4].toJson);
}

Json getArray(Json[string] map, string key, Json defaultValue = null) {
  return map.getValue(key).isArray ? map.getValue(key) : defaultValue;
}
/// 
unittest {
  Json[string] map = [
    "first": [1, 2].toJson, "second": ["a": 1].toJson, "third": [3, 4].toJson
  ];
  assert(map.getArray("first") == [1, 2].toJson);
  assert(map.getArray("second", Json("default")) == Json("default"));
  assert(map.getArray("third") == [3, 4].toJson);
}
// #endregion Json[string]

// #region Json
Json getArrays(Json json, size_t[] indices) {
  Json result = indices.filter!(index => json.isArray(index))
    .map!(index => json.getArray(index))
    .array;
  return result;
}

Json getArray(Json json, size_t index, Json defaultValue = null) {
  return json.isArray(index) ? json.getValue(index) : defaultValue;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getArrays with indices");

  Json json = [[1, 2].toJson, ["a": 1].toJson, [3, 4].toJson].toJson;
  assert(json.getArray(0) == [1, 2].toJson);
  assert(json.getArray(1, Json("default")) == Json("default"));
  assert(json.getArray(2) == [3, 4].toJson);
}

Json getArrays(Json json, string[][] paths) {
  Json result = paths.filter!(path => json.isArray(path))
    .map!(path => json.getArray(path))
    .array;
  return result;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getArrays with paths");

  Json json = parseJsonString(`{"data": { "test1": [1, 2], "test2": {"a": 1}, "test3": [3, 4]}}`);
  writeln("Json: ", json); 
  writeln(json.getValue("data"));
  writeln(json.getValue(["data", "test1"]));
  writeln(json.getValue(["data", "test2"]));
  writeln(json.getValue(["data", "test3"]));

  auto arrays = json.getArrays([["data", "test1"], ["data", "test2"], ["data", "test3"]]);
  assert(arrays.length == 2);
  assert(arrays[0] == [1, 2].toJson);
  assert(arrays[1] == [3, 4].toJson);
}

Json getArray(Json json, string[] path, Json defaultValue = null) {
  return json.isArray(path) ? json.getValue(path) : defaultValue;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getArray with path");

  Json json = parseJsonString(`{"data": { "test": [ [1, 2], {"a": 1}, [3, 4] ]}}`);
  writeln(json.getArray("data"))  ;

  assert(json.getArray(["data", "test"][0]) == [1, 2].toJson);
  assert(json.getArray(["data", "test"][1]) == [3, 4].toJson);
}

Json getArrays(Json json, string[] keys) {
  Json result = keys.filter!(key => json.isArray(key))
    .map!(key => json.getArray(key))
    .array;
  return result;
}
/// 
unittest {
  version (test_uim_root) writeln("Testing getArrays with keys");

  Json json = `{"arr1": [1, 2], "obj": {"a": 1}, "arr2": [3, 4]}`;
  auto arrays = json.getArrays(["arr1", "obj", "arr2", "nonexistent"]);
  assert(arrays.length == 2);
  assert(arrays[0] == [1, 2].toJson);
  assert(arrays[1] == [3, 4].toJson);
}

Json getArray(Json json, string key, Json defaultValue = null) {
  return json.isArray(key) ? json.getValue(key) : defaultValue;
}
/// 
unittest {
  Json json = `{"data": [ [1, 2], {"a": 1}, [3, 4] ]}`;
  assert(json.getArray("data") == [
      [1, 2].toJson, ["a": 1 ].toJson, [3, 4].toJson
    ].toJson);
  assert(json.getArray("nonexistent", Json("default")) == Json("default"));
}
// #endregion Json
