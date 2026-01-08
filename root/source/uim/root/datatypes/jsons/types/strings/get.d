module uim.root.datatypes.jsons.types.strings.get;

import uim.root;

mixin(ShowModule!());

@safe:

// #region Json[]
Json getString(Json[] jsons, size_t index, Json defaultValue = Json(null)) {
  return jsons.getValue(index).isString() ? jsons[index] : defaultValue;
}/// 
unittest {
  mixin(ShowTest!"Testing getString for Json[] with index");

  Json[] jsons = [Json("hello"), 123.toJson, Json("world")];
  assert(jsons.getString(0) == Json("hello"));
  assert(jsons.getString(1, Json("default")) == Json("default"));
  assert(jsons.getString(2) == Json("world"));
}
// #endregion Json[]

// #region Json[string]
Json getString(Json[string] map, string[] path, Json defaultValue = Json(null)) {
  return map.getValue(path).isString ? map.getValue(path) : defaultValue;
}
/// 
unittest {
  mixin(ShowTest!"Testing getString for Json[string] with path");

  Json[string] map = [
    "first": Json("hello"), "second": 123.toJson, "third": Json("world")
  ];
  assert(map.getString("first") == Json("hello"));
  assert(map.getString("second", Json("default")) == Json("default"));
  assert(map.getString("third") == Json("world"));
}

Json getString(Json[string] map, string key, Json defaultValue = Json(null)) {
  return map.getValue(key).isString ? map.getValue(key) : defaultValue;
}
/// 
unittest {
  mixin(ShowTest!"Testing getString for Json[string] with key");

  Json[string] map = [
    "first": Json("hello"), "second": 123.toJson, "third": Json("world")
  ];
  assert(map.getString("first") == Json("hello"));
  assert(map.getString("second", Json("default")) == Json("default"));
  assert(map.getString("third") == Json("world"));
}
// #endregion Json[string]

// #region Json
Json getString(Json json, size_t index, Json defaultValue = Json(null)) {
  return json.isString(index) ? json.getValue(index) : defaultValue;
}
/// 
unittest {
  mixin(ShowTest!"Testing getString for Json with index");

  Json json = [Json("hello"), 123.toJson, Json("world")].toJson;
  assert(json.getString(0) == Json("hello"));
  assert(json.getString(1, Json("default")) == Json("default"));
  assert(json.getString(2) == Json("world"));
}

Json getString(Json json, string[] path, Json defaultValue = Json(null)) {
  return json.isString(path) ? json.getValue(path) : defaultValue;
}
/// 
unittest {
  mixin(ShowTest!"Testing getString for Json with path");

  Json json = parseJsonString(`{"first": "hello", "second": 123, "third": "world"}`);
  assert(json.getString("first") == Json("hello"));
  assert(json.getString("second", Json("default")) == Json("default"));
  assert(json.getString("third") == Json("world"));
}

Json getString(Json json, string key, Json defaultValue = Json(null)) {
  return json.isString(key) ? json.getValue(key) : defaultValue;
}
/// 
unittest {
  mixin(ShowTest!"Testing getString for Json with key");

  Json json = parseJsonString(`{"first": "hello", "second": 123, "third": "world"}`);
  assert(json.getString("first") == Json("hello"));
  assert(json.getString("second", Json("default")) == Json("default"));
  assert(json.getString("third") == Json("world"));
}
// #endregion Json
