module uim.root.datatypes.jsons.remove;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Keys
Json removeKeys(Json json, string[] keys, bool delegate(string) @safe removeFunc) {
  if (!json.isObject || keys.length == 0) {
    return json;
  }

  return json.removeKeys(keys).removeMap(removeFunc);
}

Json removeKeys(Json json, string[] keys) {
  if (!json.isObject || keys.length == 0) {
    return json;
  }

  return removeMap(json, (string key, Json value) => keys.hasValue(key));
}

Json removeKeys(Json json, bool delegate(string) @safe removeFunc) {
  if (!json.isObject) {
    return json;
  }

  return removeMap(json, (string key, Json value) => removeFunc(key));
}
// #endregion Keys

// #region Values
Json removeValues(Json json, Json[] values, bool delegate(Json) @safe removeFunc) {
  if (!json.isObject || values.length == 0) {
    return json;
  }

  return json.removeValues(values).removeValues(removeFunc);
}

Json removeValues(Json json, Json[] values) {
  if (values.length == 0) {
    return json;
  }

  if (json.isArray) {
    return json.toJson.removeValues(values).toJson;
  }
  if (json.isObject) {
    return removeMap(json, (string key, Json value) => values.hasValue(value));
  }
  return json;
}

Json removeValues(Json json, bool delegate(Json) @safe removeFunc) {
  if (json.isArray) {
    return json.toJson.removeValues(removeFunc).toJson;
  }
  if (json.isObject) {
    return removeMap(json, (string key, Json value) @safe => removeFunc(value));
  }

  return json;
}
// #endregion Values

// #region Map
// #region Func(key)
Json removeMap(Json json, bool delegate(string) @safe removeFunc) {
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
