module uim.root.datatypes.jsons.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json
// #region paths
// #region with paths and filterFunc
Json filterPaths(Json json, string[][] paths, bool delegate(string[]) @safe filterFunc) {
  if (json.isObject) {
    Json result = Json.emptyObject;
    auto filteredPaths = paths.filter!(path => json.toMap.hasPath(path) && filterFunc(path)).array;
    foreach (path; filteredPaths) {
      result = result.setValue(path, json.getValue(path));
    }
    return result;
  }
  return Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterPaths for Json with paths and filterFunc");

  Json json = [
    "a": [
      "b": [
        "c": Json(1),
        "d": Json(2)
      ].toJson,
      "e": Json(3)
    ].toJson,
    "x": Json(4),
    "y": Json(5)
  ].toJson;

  auto filtered = filterPaths(json, [["a", "b", "c"], ["x"]], (string[] path) => path[0] == "a");
  assert(filtered.isObject);
  assert(filtered.length == 1);
  assert(filtered.hasKey("a"));
  assert(filtered.getValue("a").isObject);
  assert(filtered.getValue("a").hasKey("b"));
  assert(filtered.getValue("a").getValue("b").isObject);
  assert(filtered.getValue("a").getValue("b").hasKey("c"));
  assert(filtered.getValue("a").getValue("b").getValue("c") == Json(1));
}
// #endregion with paths and filterFunc

// #region with paths
Json filterPaths(Json json, string[][] paths) {
  if (json.isObject) {
    Json result = Json.emptyObject;
    auto filteredPaths = paths.filter!(path => json.toMap.hasPath(path)).array;
    foreach (path; filteredPaths) {
      result = result.setValue(path, json.getValue(path));
    }
    return result;
  }
  return Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterPaths for Json with paths");

  Json json = [
    "a": [
      "b": [
        "c": Json(1),
        "d": Json(2)
      ].toJson,
      "e": Json(3)
    ].toJson,
    "x": Json(4),
    "y": Json(5)
  ].toJson;

  auto filtered = filterPaths(json, [["a", "b", "c"], ["x"]]);
  assert(filtered.isObject);
  assert(filtered.toMap.length == 2);
  assert(filtered.toMap.hasKey("a"));
  assert(filtered.toMap.getValue("a").isObject);
  assert(filtered.toMap.getValue("a").toMap.hasKey("b"));
  assert(filtered.toMap.getValue("a").toMap.getValue("b").isObject);
  assert(filtered.toMap.getValue("a").toMap.getValue("b").toMap.hasKey("c"));
  assert(filtered.toMap.getValue("a").toMap.getValue("b").toMap.getValue("c") == Json(1));
  assert(filtered.toMap.hasKey("x"));
  assert(filtered.toMap.getValue("x") == Json(4));
}
// #endregion with paths
// #endregion paths

// #region keys
// #region with keys and filterFunc
Json filterKeys(Json json, string[] keys, bool delegate(string) @safe filterFunc) {
  return json.isObject ? json.toMap.filterKeys(keys, filterFunc).toJson : Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterKeys for Json with keys and filterFunc");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ].toJson;

  auto filtered = filterKeys(json, ["a", "b", "c", "d"], (key) => key != "b" && key != "d");
  assert(filtered.isObject);
  assert(filtered.toMap.length == 2);
  assert(filtered.toMap.hasKey("a"));
  assert(filtered.toMap.hasKey("c"));
}
// #endregion with keys and filterFunc

// #region with keys
Json filterKeys(Json json, string[] keys) {
  return json.isObject ? json.toMap.filterKeys(keys).toJson : Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterKeys for Json with keys");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ].toJson;

  auto filtered = filterKeys(json, ["a", "c", "e"]);
  assert(filtered.isObject);
  assert(filtered.toMap.length == 2);
  assert(filtered.toMap.hasKey("a"));
  assert(filtered.toMap.hasKey("c"));
}
// #endregion with keys

// #region with filterFunc
Json filterKeys(Json json, bool delegate(string) @safe filterFunc) {
  return json.isObject ? json.toMap.filterKeys(filterFunc).toJson : Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterKeys for Json with filterFunc");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ].toJson;

  auto filtered = filterKeys(json, (key) => key == "b" || key == "d");
  assert(filtered.isObject);
  assert(filtered.toMap.length == 2);
  assert(filtered.toMap.hasKey("b"));
  assert(filtered.toMap.hasKey("d"));
}
// #endregion with filterFunc
// #endregion keys

// #region values
// #region with values and filterFunc
Json filterValues(Json json, Json[] values, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.toArray.filterValues(values, filterFunc).toJson;
  }
  if (json.isObject) {
    return json.toMap.filterValues(values, filterFunc).toJson;
  }
  return Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json with values and filterFunc");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ].toJson;

  auto filtered = filterValues(json, [Json(2), Json(3), Json(4)], (value) => value.to!int % 2 == 0);
  assert(filtered.isObject);
  assert(filtered.toMap.length == 2);
  assert(filtered.toMap.hasKey("b"));
  assert(filtered.toMap.hasKey("d"));
}
// #endregion with values and filterFunc

// #region with values
Json filterValues(Json json, Json[] values) {
  if (json.isArray) {
    return json.toArray.filterValues(values).toJson;
  }
  if (json.isObject) {
    return json.toMap.filterValues(values).toJson;
  }
  return Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json with values");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ].toJson;

  auto filtered = filterValues(json, [Json(2), Json(4), Json(5)]);
  assert(filtered.isObject);
  assert(filtered.toMap.length == 2);
  assert(filtered.toMap.hasKey("b"));
  assert(filtered.toMap.hasKey("d"));
}
// #endregion with values

// #region with filterFunc(value)
Json filterValues(Json json, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.toArray.filterValues(filterFunc).toJson;
  }
  if (json.isObject) {
    return json.toMap.filterValues(filterFunc).toJson;
  }
  return Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json with filterFunc");

  Json json = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ].toJson;

  auto filtered = filterValues(json, (value) => value.to!int > 2);
  assert(filtered.isObject);
  assert(filtered.toMap.length == 2);
  assert(filtered.toMap.hasKey("c"));
  assert(filtered.toMap.hasKey("d"));
}
// #endregion with filterFunc(value)
// #endregion values

// #region indices
// #region with indices and filterFunc
Json filterIndices(Json json, size_t[] indices, bool delegate(size_t) @safe filterFunc) {
  if (json.isArray) {
    return json.toArray.filterIndices(indices, filterFunc).toJson;
  }
  return Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json with indices and filterFunc");

  Json json = [Json(1), Json(2), Json(3), Json(4), Json(5)].toJson;

  auto filtered = filterIndices(json, [0, 1, 2, 3, 4], (index) => index % 2 == 0);
  assert(filtered.isArray);
  assert(filtered.length == 3);
  assert(filtered[0] == Json(1));
  assert(filtered[1] == Json(3));
  assert(filtered[2] == Json(5));
}
// #endregion with indices and filterFunc

// #region with indices
Json filterIndices(Json json, size_t[] indices) {
  if (json.isArray) {
    return json.toArray.filterIndices(indices).toJson;
  }
  return Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json with indices");

  Json json = [Json(1), Json(2), Json(3), Json(4), Json(5)].toJson;

  auto filtered = filterIndices(json, [1, 3, 5]);
  assert(filtered.isArray);
  assert(filtered.length == 2);
  assert(filtered[0] == Json(2));
  assert(filtered[1] == Json(4));
}
// #endregion with indices

// #region with filterFunc
Json filterIndices(Json json, bool delegate(size_t) @safe filterFunc) {
  if (json.isArray) {
    return json.toArray.filterIndices(filterFunc).toJson;
  }
  return Json(null);
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json with filterFunc");

  Json json = [Json(1), Json(2), Json(3), Json(4), Json(5)].toJson;

  auto filtered = filterIndices(json, (index) => index % 2 == 0);
  assert(filtered.isArray);
  assert(filtered.length == 3);
  assert(filtered[0] == Json(1));
  assert(filtered[1] == Json(3));
  assert(filtered[2] == Json(5));
}
// #endregion with filterFunc
// #endregion indices
// #endregion Json

// #region Json[string]
// #region paths
// #region with paths and filterFunc
Json[string] filterPaths(Json[string] map, string[][] paths, bool delegate(string[]) @safe filterFunc) {
  if (map.length == 0 || paths.length == 0) {
    return null;
  }

  Json[string] result;
  foreach (path; paths.filter!(p => map.hasPath(p) && filterFunc(p)).array) {
    result = result.setValue(path, map.getValue(path));
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterPaths for Json with paths and filterFunc");

  Json[string] map = [
    "a": [
      "b": [
        "c": Json(1),
        "d": Json(2)
      ].toJson,
      "e": Json(3)
    ].toJson,
    "x": Json(4),
    "y": Json(5)
  ];

  auto filtered = filterPaths(map, [["a", "b", "c"], ["x"]], (path) => path[0] == "a");
  assert(filtered.length == 1);
  assert(filtered.hasPath(["a"]));
  assert(filtered.getValue(["a"]).isObject);
  assert(filtered.getValue(["a"]).hasKey("b"));
  assert(filtered.getValue(["a"]).getValue("b").isObject);
  assert(filtered.getValue(["a"]).getValue("b").hasKey("c"));
  assert(filtered.getValue(["a"]).getValue("b").getValue("c") == Json(1));
}
// #endregion with paths and filterFunc

// #region with paths
Json[string] filterPaths(Json[string] map, string[][] paths) {
  if (map.length == 0 || paths.length == 0) {
    return null;
  }

  Json[string] result;
  foreach (path; paths) {
    if (map.hasPath(path)) {
      result = result.setValue(path, map.getValue(path));
    }
  }

  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterPaths for Json with paths");

  Json[string] map = [
    "a": [
      "b": [
        "c": Json(1),
        "d": Json(2)
      ].toJson,
      "e": Json(3)
    ].toJson,
    "x": Json(4),
    "y": Json(5)
  ];

  auto filtered = filterPaths(map, [["a", "b", "c"], ["x"]]);
  assert(filtered.length == 2);
  assert(filtered.hasPath(["a"]));
  assert(filtered.getValue(["a"]).isObject);
  assert(filtered.getValue(["a"]).toMap.hasKey("b"));
  assert(filtered.getValue(["a"]).toMap.getValue("b").isObject);
  assert(filtered.getValue(["a"]).toMap.getValue("b").toMap.hasKey("c"));
  assert(filtered.getValue(["a"]).toMap.getValue("b").toMap.getValue("c") == Json(1));
  assert(filtered.hasPath(["x"]));
  assert(filtered.getValue(["x"]) == Json(4));
}
// #endregion with paths
// #endregion paths

// #region keys
// #region with keys and filterFunc
Json[string] filterKeys(Json[string] map, string[] keys, bool delegate(string) @safe filterFunc) {
  if (map.length == 0 || keys.length == 0) {
    return null;
  }

  Json[string] result;
  foreach (key; keys) {
    if (map.hasKey(key) && filterFunc(key)) {
      result[key] = map[key];
    }
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterKeys for Json with keys and filterFunc");

  Json[string] map = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ];

  auto filtered = filterKeys(map, ["a", "b", "c", "d"], (key) => key != "b" && key != "d");
  assert(filtered.length == 2);
  assert(filtered.hasKey("a"));
  assert(filtered.hasKey("c"));
}
// #endregion with keys and filterFunc

// #region with keys
Json[string] filterKeys(Json[string] map, string[] keys) {
  if (map.length == 0 || keys.length == 0) {
    return null;
  }

  Json[string] result;
  foreach (key; keys) {
    if (map.hasKey(key)) {
      result[key] = map[key];
    }
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterKeys for Json with keys");

  Json[string] map = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ];

  auto filtered = filterKeys(map, ["a", "c", "e"]);
  assert(filtered.length == 2);
  assert(filtered.hasKey("a"));
  assert(filtered.hasKey("c"));
}
// #endregion with keys

// #region with filterFunc
Json[string] filterKeys(Json[string] map, bool delegate(string) @safe filterFunc) {
  if (map.length == 0) {
    return null;
  }

  Json[string] result;
  foreach (key; map.keys) {
    if (filterFunc(key)) {
      result[key] = map[key];
    }
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterKeys for Json with filterFunc");

  Json[string] map = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ];

  auto filtered = filterKeys(map, (key) => key == "b" || key == "d");
  assert(filtered.length == 2);
  assert(filtered.hasKey("b"));
  assert(filtered.hasKey("d"));
}
// #endregion with filterFunc
// #endregion keys

// #region values
// #region with values and filterFunc

Json[string] filterValues(Json[string] map, Json[] values, bool delegate(Json) @safe filterFunc) {
  if (map.length == 0 || values.length == 0) {
    return null;
  }

  Json[string] result;
  foreach (key, value; map) {
    if (values.hasValue(value) && filterFunc(value)) {
      result[key] = value;
    }
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json[string] with values and filterFunc");

  Json[string] map = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ];

  auto filtered = filterValues(map, [Json(2), Json(3), Json(4)], (value) => value.to!int % 2 == 0);
  assert(filtered.length == 2);
  assert(filtered.hasKey("b"));
  assert(filtered.hasKey("d"));
}
// #endregion with values and filterFunc

// #region with values
Json[string] filterValues(Json[string] map, Json[] values) {
  Json[string] result;
  foreach (key, value; map) {
    if (values.hasValue(value)) {
      result[key] = value;
    }
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json[string] with values");

  Json[string] map = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ];

  auto filtered = filterValues(map, [Json(2), Json(4), Json(5)]);
  assert(filtered.length == 2);
  assert(filtered.hasKey("b"));
  assert(filtered.hasKey("d"));
}
// #endregion with values

// #region with filterFunc
Json[string] filterValues(Json[string] map, bool delegate(Json) @safe filterFunc) {
  Json[string] result;
  foreach (key, value; map) {
    if (filterFunc(value)) {
      result[key] = value;
    }
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json[string] with filterFunc");

  Json[string] map = [
    "a": Json(1),
    "b": Json(2),
    "c": Json(3),
    "d": Json(4)
  ];

  auto filtered = filterValues(map, (value) => value.to!int > 2);
  assert(filtered.length == 2);
  assert(filtered.hasKey("c"));
  assert(filtered.hasKey("d"));
}
// #endregion with filterFunc
// #endregion values
// #endregion Json[string]

// #region Json[]
// #region indices
// #region with indices and filterFunc
Json[] filterIndices(Json[] jsons, size_t[] indices, bool delegate(size_t) @safe filterFunc) {
  if (jsons.length == 0 || indices.length == 0) {
    return null;
  }

  Json[] result;
  foreach (index, value; jsons) {
    if (indices.hasValue(index) && filterFunc(index)) {
      result ~= value;
    }
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterIndices for Json[] with indices and filterFunc");

  Json[] jsons = [Json(1), Json(2), Json(3), Json(4), Json(5)];

  auto filtered = filterIndices(jsons, [0, 1, 2, 3, 4], (index) => index % 2 == 0);
  assert(filtered.length == 3);
  assert(filtered[0] == Json(1));
  assert(filtered[1] == Json(3));
  assert(filtered[2] == Json(5));
}
// #endregion with indices and filterFunc

// #region with indices
Json[] filterIndices(Json[] jsons, size_t[] indices) {
  if (jsons.length == 0 || indices.length == 0) {
    return jsons;
  }

  Json[] result;
  foreach (index, value; jsons) {
    if (indices.hasValue(index)) {
      result ~= value;
    }
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterIndices for Json[] with indices");

  Json[] jsons = [Json(1), Json(2), Json(3), Json(4), Json(5)];

  auto filtered = filterIndices(jsons, [1, 3, 5]);
  assert(filtered.length == 2);
  assert(filtered[0] == Json(2));
  assert(filtered[1] == Json(4));
}
// #endregion with indices

// #region with filterFunc
Json[] filterIndices(Json[] jsons, bool delegate(size_t) @safe filterFunc) {
  if (jsons.length == 0) {
    return jsons;
  }

  Json[] result;
  foreach (index, value; jsons) {
    if (filterFunc(index)) {
      result ~= value;
    }
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterIndices for Json[] with filterFunc");

  Json[] jsons = [Json(1), Json(2), Json(3), Json(4), Json(5)];

  auto filtered = filterIndices(jsons, (index) => index % 2 != 0);
  assert(filtered.length == 2);
  assert(filtered[0] == Json(2));
  assert(filtered[1] == Json(4));
}
// #endregion filterFunc
// #endregion indices

// #region values
// #region with values and filterFunc
Json[] filterValues(Json[] jsons, Json[] values, bool delegate(Json) @safe filterFunc) {
  if (jsons.length == 0 || values.length == 0) {
    return null;
  }

  Json[] result;
  foreach (value; jsons) {
    if (values.hasValue(value) && filterFunc(value)) {
      result ~= value;
    }
  }

  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json[] with values and filterFunc");

  Json[] jsons = [Json(1), Json(2), Json(3), Json(4), Json(5)];

  auto filtered = filterValues(jsons, [Json(2), Json(3), Json(4)], (value) => value.to!int % 2 == 0);
  assert(filtered.length == 2);
  assert(filtered[0] == Json(2));
  assert(filtered[1] == Json(4));
}
// #endregion with values and filterFunc

// #region with values
Json[] filterValues(Json[] jsons, Json[] values) {
  if (jsons.length == 0 || values.length == 0) {
    return null;
  }

  Json[] result;
  foreach (value; jsons) {
    if (values.hasValue(value)) {
      result ~= value;
    }
  }

  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json[] with values");

  Json[] jsons = [Json(1), Json(2), Json(3), Json(4), Json(5)];

  auto filtered = filterValues(jsons, [Json(2), Json(4), Json(6)]);
  assert(filtered.length == 2);
  assert(filtered[0] == Json(2));
  assert(filtered[1] == Json(4));
}
// #endregion with values

// #region with filterFunc
Json[] filterValues(Json[] jsons, bool delegate(Json) @safe filterFunc) {
  if (jsons.length == 0) {
    return null;
  }

  Json[] result;
  foreach (value; jsons) {
    if (filterFunc(value)) {
      result ~= value;
    }
  }
  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing filterValues for Json[] with filterFunc");

  Json[] jsons = [Json(1), Json(2), Json(3), Json(4), Json(5)];

  auto filtered = filterValues(jsons, (value) => value.to!int > 2);
  assert(filtered.length == 3);
  assert(filtered[0] == Json(3));
  assert(filtered[1] == Json(4));
  assert(filtered[2] == Json(5));
}
// #endregion with filterFunc
// #endregion values
// #endregion Json[]
