module uim.root.datatypes.jsons.json.remove;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

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
