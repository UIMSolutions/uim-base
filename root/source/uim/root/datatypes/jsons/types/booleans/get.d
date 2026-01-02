module uim.root.datatypes.jsons.types.booleans.get;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
Json getBoolean(Json[] jsons, size_t index, Json defaultValue = null) {
  return jsons.getValue(index).isBoolean() ? jsons[index] : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getBoolean for Json[] with index");

  Json[] jsons = [true.toJson, 123.toJson, false.toJson];
  assert(jsons.getBoolean(0) == true.toJson);
  assert(jsons.getBoolean(1, Json("default")) == Json("default"));
  assert(jsons.getBoolean(2) == false.toJson);
}
// #endregion Json[]

// #region Json[string]
Json getBoolean(Json[string] map, string[] path, Json defaultValue = null) {
  return map.getValue(path).isBoolean ? map.getValue(path) : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getBoolean for Json[string] with path");

  Json[string] map = [
    "first": true.toJson, "second": 123.toJson, "third": false.toJson
  ];
  assert(map.getBoolean("first") == true.toJson);
  assert(map.getBoolean("second", Json("default")) == Json("default"));
  assert(map.getBoolean("third") == false.toJson);
}

Json getBoolean(Json[string] map, string key, Json defaultValue = null) {
  return map.getValue(key).isBoolean ? map.getValue(key) : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getBoolean for Json[string] with key");

  Json[string] map = [
    "first": true.toJson, "second": 123.toJson, "third": false.toJson
  ];
  assert(map.getBoolean("first") == true.toJson);
  assert(map.getBoolean("second", Json("default")) == Json("default"));
  assert(map.getBoolean("third") == false.toJson);
}
// #endregion Json[string]

// #region Json
Json getBoolean(Json json, size_t index, Json defaultValue = null) {
  return json.isBoolean(index) ? json.getValue(index) : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getBoolean for Json with index");

  Json json = [true.toJson, 123.toJson, false.toJson].toJson;
  assert(json.getBoolean(0) == true.toJson);
  assert(json.getBoolean(1, Json("default")) == Json("default"));
  assert(json.getBoolean(2) == false.toJson);
}

Json getBoolean(Json json, string[] path, Json defaultValue = null) {
  return json.isBoolean(path) ? json.getValue(path) : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getBoolean for Json with path");

  Json json = parseJsonString(`{"first": true, "second": 123, "third": false}`);
  assert(json.getBoolean("first") == true.toJson);
  assert(json.getBoolean("second", Json("default")) == Json("default"));
  assert(json.getBoolean("third") == false.toJson);
}

Json getBoolean(Json json, string key, Json defaultValue = null) {
  return json.isBoolean(key) ? json.getValue(key) : defaultValue;
}
/// 
unittest {
  version (test_uim_root)
    writeln("Testing getBoolean for Json with key");

  Json json = parseJsonString(`{"first": true, "second": 123, "third": false}`);
  assert(json.getBoolean("first") == true.toJson);
  assert(json.getBoolean("second", Json("default")) == Json("default"));
  assert(json.getBoolean("third") == false.toJson);
}
// #endregion Json
