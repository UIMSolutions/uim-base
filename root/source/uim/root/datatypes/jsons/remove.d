module uim.root.datatypes.jsons.remove;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region keys
// #region keys with func
Json removeKeys(Json json, string[] keys, bool delegate(string) @safe removeFunc) {
  if (!json.isObject || keys.length == 0) {
    return json;
  }

  Json result = Json.emptyObject;
  foreach( key, value; json.byKeyValue) {
    if (!keys.hasValue(key) || !removeFunc(key)) {
      result[key] = value;
    }
  }

  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeKeys with keys and func");

  Json json = parseJsonString(`{
    "name": "John",
    "age": 30,
    "city": "New York",
    "country": "USA"
  }`);

  auto result = removeKeys(json, ["age", "city"], (string key) @safe => key == "city");
  assert(result.length == 3);
  assert(result["name"] == "John");
  assert(result["age"] == 30);
  assert(result["country"] == "USA");
}
// #endregion keys with func

// #region keys
Json removeKeys(Json json, string[] keys) {
  if (!json.isObject || keys.length == 0) {
    return json;
  }

  Json result = Json.emptyObject;
  foreach( key, value; json.byKeyValue) {
    if (!keys.hasValue(key)) {
      result[key] = value;
    }
  }

  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeKeys with keys");

  Json json = parseJsonString(`{
    "name": "John",
    "age": 30,
    "city": "New York",
    "country": "USA"
  }`);

  auto result = removeKeys(json, ["age", "city"]);
  assert(result.length == 2);
  assert(result["name"] == "John");
  assert(result["country"] == "USA");
}
// #endregion keys

// #region func(key)
Json removeKeys(Json json, bool delegate(string) @safe removeFunc) {
  if (!json.isObject) {
    return json;
  }

  Json result = Json.emptyObject;
  foreach( key, value; json.byKeyValue) {
    if (!removeFunc(key)) {
      result[key] = value;
    }
  }

  return result;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeKeys with func");

  Json json = parseJsonString(`{
    "name": "John",
    "age": 30,
    "city": "New York",
    "country": "USA"
  }`);

  auto result = removeKeys(json, (string key) @safe => key == "age" || key == "city");
  assert(result.length == 2);
  assert(result["name"] == "John");
  assert(result["country"] == "USA");
}
// #endregion func(key)
// #endregion keys

// #region values
// #region values with func
Json removeValues(Json json, Json[] values, bool delegate(Json) @safe removeFunc) {
  if (values.length == 0) {
    return json;
  }

  if (json.isArray) {
    Json result = Json.emptyArray;
    foreach(value; json.byValue) {
      if (!values.hasValue(value) || !removeFunc(value)) {
        result ~= value;
      }
    }
  }
  if (json.isObject) {
    Json result = Json.emptyObject;
    foreach(key, value; json.byKeyValue) {
      if (!values.hasValue(value) || !removeFunc(value)) {
        result[key] = value;
      }
    }
  }

  return json;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeValues with values and func");

  Json json = parseJsonString(`{
    "name": "John",
    "age": 30,
    "city": "New York",
    "country": "USA"
  }`);

  auto result = removeValues(json, [Json(30), Json("New York")],
    (Json value) @safe => value == Json("New York"));
  assert(result.length == 3);
  assert(result["name"] == "John");
  assert(result["age"] == 30);
  assert(result["country"] == "USA");
}
// #endregion values with func

Json removeValues(Json json, Json[] values) {
  if (values.length == 0) {
    return json;
  }

  if (json.isArray) {
    Json result = Json.emptyArray;
    foreach(value; json.byValue) {
      if (!values.hasValue(value)) {
        result ~= value;
      }
    }
  }
  if (json.isObject) {
    Json result = Json.emptyObject;
    foreach(key, value; json.byKeyValue) {
      if (!values.hasValue(value)) {
        result[key] = value;
      }
    }
  }

  return json;
}
///
unittest {
  version (test_uim_root)
    writeln("Testing removeValues with values");

  Json json = parseJsonString(`{
    "name": "John",
    "age": 30,
    "city": "New York",
    "country": "USA"
  }`);

  auto result = removeValues(json, [Json(30), Json("New York")]);
  assert(result.length == 2);
  assert(result["name"] == "John");
  assert(result["country"] == "USA");
}

Json removeValues(Json json, bool delegate(Json) @safe removeFunc) {
  if (values.length == 0) {
    return json;
  }

  if (json.isArray) {
    Json result = Json.emptyArray;
    foreach(value; json.byValue) {
      if (!removeFunc(value)) {
        result ~= value;
      }
    }
  }
  if (json.isObject) {
    Json result = Json.emptyObject;
    foreach(key, value; json.byKeyValue) {
      if (!removeFunc(value)) {
        result[key] = value;
      }
    }
  }

  return json;
}
// #endregion Values

// #region Map
// #region Func(key)
Json removeKeys(Json json, bool delegate(string) @safe removeFunc) {
  return removeMap(json, (string key, Json value) @safe => removeFunc(key));
}
// #endregion Func(key)

// #region Func(value)
Json removeMap(Json json, bool delegate(Json) @safe removeFunc) {
  return removeMap(json, (string key, Json value) @safe => removeFunc(value));

}
// #endregion Func(value)

// #region Func(key, value)
Json removeMap(Json json, bool delegate(string key, Json value) @safe removeFunc) {
  Json results;
  foreach (key, value; json.byKeyValue) {
    if (!removeFunc(key, value)) {
      results[key] = value;
    }
  }
  return results;
}
// #endregion Func(key, value)
// #endregion Map
