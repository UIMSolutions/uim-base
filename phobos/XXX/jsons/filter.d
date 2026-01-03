module uim.root.datatypes.jsons.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region filterKeys
Json filterKeys(Json json, string[] keys, bool delegate(string) @safe filterFunc) {
  return json.isObject
    ? json.filterKeys(keys).filterKeys(filterFunc) : Json(null);
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing filterKeys with keys and filterFunc");

  Json json = parseJsonString(`{"a":1,"b":2,"c":3,"d":4}`);
  Json filtered = json.filterKeys(["a", "c"], (string key) @safe => key == "a");
  assert(filtered["a"] == Json(1));
}

Json filterKeys(Json json, string[] keys) {
  return json.isObject
    ? json.filterKeys((string key) => json.hasKey(key)) : Json(null);
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing filterKeys with keys");

  Json json = parseJsonString(`{"a":1,"b":2,"c":3,"d":4}`);
  Json filtered = json.filterKeys(["a", "c"]);
  assert(filtered["a"] == Json(1) && filtered["c"] == Json(3));
}

Json filterKeys(Json json, bool delegate(string) @safe filterFunc) {
  if (json.isObject) {
    Json(null);
  }
  Json result = Json.emptyObject;
  json.byKeyValue
    .filter!(kv => filterFunc(kv.key))
    .each!(kv => result[kv.key] = kv.value);
  return result;
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing filterKeys with filterFunc");

  Json json = parseJsonString(`{"a":1,"b":2,"c":3,"d":4}`);
  Json filtered = json.filterKeys((string key) @safe => key == "b" || key == "d");
  assert(filtered["b"] == Json(2) && filtered["d"] == Json(4));
}
// #endregion filterKeys

// #region filterValues
Json filterValues(Json json, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  if (!json.isArray) {
    return Json(null);
  }

  Json result = Json.emptyArray;
  foreach (index, value; json.byValue) {
    if (json.hasValue(index) && filterFunc(value)) {
      result ~= value;
    }
  }
  return result;
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing filterValues with indices and filterFunc");

  Json json = [
    1.toJson, "not a double".toJson, 2.5.toJson, 3.toJson, 4.0.toJson
  ];
  auto filtered = json.filterValues([0, 1, 2, 3, 4], (Json value) @safe => value.isDouble);
  assert(filtered.length == 2);
  assert(filtered[0] == 2.5.toJson);
  assert(filtered[1] == 4.0.toJson);
}

Json filterValues(Json json, size_t[] indices) {
  if (!json.isArray) {
    return Json(null);
  }

  Json result = Json.emptyArray;
  foreach (index, value; json.byValue) {
    if (json.hasValue(index)) {
      result ~= value;
    }
  }
  return result;
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing filterValues with indices");

  Json json = [
    1.toJson, "not a double".toJson, 2.5.toJson, 3.toJson, 4.0.toJson
  ];
  auto filtered = json.filterValues([0, 2, 4]);
  assert(filtered.length == 3);
  assert(filtered[0] == 1.toJson);
  assert(filtered[1] == 2.5.toJson);
  assert(filtered[2] == 4.0.toJson);
}

Json filterValues(Json json, Json[] values, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.byValue.filter!((Json json) => values.hasValue(json) && filterFunc(json))
      .array.toJson;
  }
  if (json.isObject) {
    return json.filterMap((string key, Json json) => values.hasValue(json) && filterFunc(json));
  }
  return Json(null);
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing filterValues with values and filterFunc");

  Json json = [
    1.toJson, "not a double".toJson, 2.5.toJson, 3.toJson, 4.0.toJson
  ];
  Json[] values = [2.5.toJson, 4.0.toJson, 3.toJson];
  auto filtered = json.filterValues(values, (Json value) @safe => value.isDouble);
  assert(filtered.length == 2);
  assert(filtered[0] == 2.5.toJson);
  assert(filtered[1] == 4.0.toJson);
}

Json filterValues(Json json, Json[] values) {
  return json.filterValues((Json value) => values.hasValue(value));
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing filterValues with values");

  Json json = [
    1.toJson, "not a double".toJson, 2.5.toJson, 3.toJson, 4.0.toJson
  ];
  Json[] values = [2.5.toJson, 4.0.toJson];
  auto filtered = json.filterValues(values);
  assert(filtered.length == 2);
  assert(filtered[0] == 2.5.toJson);
  assert(filtered[1] == 4.0.toJson);
}

Json filterValues(Json json, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.byValue.filter!(json => filterFunc(json)).array.toJson;
  }
  if (json.isObject) {
    return json.filterMap((string key, Json json) => filterFunc(json));
  }
  return Json(null);
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing filterValues with filterFunc");

  Json json = [
    1.toJson, "not a double".toJson, 2.5.toJson, 3.toJson, 4.0.toJson
  ];
  auto filtered = json.filterValues((Json value) @safe => value.isDouble);
  assert(filtered.length == 3);
  assert(filtered[0] == 2.5.toJson);
  assert(filtered[1] == 3.toJson);
  assert(filtered[2] == 4.0.toJson);
}
// #endregion filterValues

// #region filterMap
Json filterMap(Json json, bool delegate(string) @safe filterFunc) {
  return json.filterMap((string key, Json value) => filterFunc(key));
}

Json filterMap(Json json, bool delegate(Json) @safe filterFunc) {
  return json.filterMap((string key, Json value) => filterFunc(value));
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing filterMap with filterFunc(key, value)");

  Json json = parseJsonString(`{"a":1,"b":2,"c":3,"d":4}`);
  Json filtered = json.filterMap((string key, Json value) @safe => key == "a" || value.toInt == 4);
  assert(filtered["a"] == Json(1) && filtered["d"] == Json(4));
}

Json filterMap(Json json, bool delegate(string, Json) @safe filterFunc) {
  if (!json.isObject) {
    return Json(null);
  }

  Json result = Json.emptyObject;
  json.byKeyValue
    .filter!(kv => filterFunc(kv.key, kv.value))
    .each!(kv => result[kv.key] = kv.value);
  return result;
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing filterMap with filterFunc(key, value)");

  Json json = parseJsonString(`{"a":1,"b":2,"c":3,"d":4}`);
  Json filtered = json.filterMap((string key, Json value) @safe => key == "b" && value.toInt == 2);
  assert(filtered["b"] == Json(2));
}
// #endregion filterMap
