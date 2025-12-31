module uim.root.datatypes.jsons.filter;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region filterKeys
Json filterKeys(Json json, string[] keys, bool delegate(string) @safe filterFunc) {
  return json.isObject
    ? json.filterKeys(keys).filterKeys(filterFunc) : Json(null);
}
/// 
unittest {
  Json json = parseJsonString(`{"a":1,"b":2,"c":3,"d":4}`);
  Json filtered = filterKeys(json, ["a", "c"], (string key) @safe => key == "a");
  assert(filtered.toString == `{"a":1}`);
}

Json filterKeys(Json json, string[] keys) {
  return json.isObject
    ? json.filterKeys((string key) => json.hasKey(key)) : Json(null);
}
/// 
unittest {
  Json json = parseJsonString(`{"a":1,"b":2,"c":3,"d":4}`);
  Json filtered = filterKeys(json, ["a", "c"]);
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
  Json json = parseJsonString(`{"a":1,"b":2,"c":3,"d":4}`);
  Json filtered = filterKeys(json, (string key) @safe => key == "b" || key == "d");
  assert(filtered["b"] == Json(2) && filtered["d"] == Json(4));
}
// #endregion filterKeys

// #region filterValues
Json filterValues(Json json, size_t[] indices, bool delegate(Json) @safe filterFunc) {
  return json.filterValues(indices).filterValues(filterFunc);
}

Json filterValues(Json json, size_t[] indices) {
  Json result = Json.emptyArray;
  foreach (index, value; json.toArray) {
    if (hasValue(indices, index)) {
      result ~= value;
    }
  }
  return result;
}

Json filterValues(Json json, Json[] values, bool delegate(Json) @safe filterFunc) {
  return json.filterValues(values).filterValues(filterFunc);
}

Json filterValues(Json json, Json[] values) {
  return json.filterValues((Json value) => values.hasValue(value));
}

Json filterValues(Json json, bool delegate(Json) @safe filterFunc) {
  if (json.isArray) {
    return json.byValue.filter!(json => filterFunc(json)).array.toJson;
  } else if (json.isObject) {
    Json result = Json.emptyObject;
    json.byKeyValue
      .filter!(kv => filterFunc(kv.value))
      .each!(kv => result[kv.key] = kv.value);
    return result;
  }
  return Json(null);
}
// #endregion filterValues

// #region filterMap
Json filterMap(Json json, bool delegate(string) @safe filterFunc) {
  Json result = Json.emptyObject;
  if (json.isObject) {
    json.byKeyValue
      .filter!(kv => filterFunc(kv.key))
      .each!(kv => result[kv.key] = kv.value);
  }
  return result;
}

Json filterMap(Json json, bool delegate(Json) @safe filterFunc) {
  Json result = Json.emptyObject;
  if (json.isObject) {
    json.byKeyValue
      .filter!(kv => filterFunc(kv.value))
      .each!(kv => result[kv.key] = kv.value);
  }
  return result;
}

Json filterMap(Json json, bool delegate(string, Json) @safe filterFunc) {
  Json result = Json.emptyObject;
  if (json.isObject) {
    json.byKeyValue
      .filter!(kv => filterFunc(kv.key, kv.value))
      .each!(kv => result[kv.key] = kv.value);
  }
  return result;
}
// #endregion filterMap
