module uim.root.datatypes.jsons.json.remove;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
Json[] removeStrings(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.filter!(json => !foundString(json, removeFunc)).array;
}

Json[] removeStrings(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices).removeStrings;
}

Json[] removeStrings(Json[] jsons) {
  return jsons.filter!(json => !json.isString).array;
}

protected bool foundString(Json json, bool delegate(Json value) @safe removeFunc) {
  return json.isString && removeFunc(json);
}
// #endregion Json[]

Json removeAll(Json json) {
  if (json.isObject) {
    json = Json.emptyObject;
  }
  else if (json.isArray) {
    json = Json.emptyArray;
  }
  else {
    json = Json(null);
  }

  return json;
}

Json remove(Json json, string[] keys) {
  keys.each!(k => json.remove(k));
  return json;
}

Json remove(Json json, string key) {
  if (!json.isObject) {
    return json;
  }

  auto result = json;
  result.remove(key);
  return result;
}
