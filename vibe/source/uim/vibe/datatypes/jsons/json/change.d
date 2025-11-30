module uim.vibe.datatypes.jsons.json.change;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/// Update the Json object with another Json object (merging key-value pairs).
Json update(Json json, Json map) {
  if (!json.isObject || !map.isObject) {
    return json;
  }

  foreach (key, value; map.byKeyValue) {
    json = json.update(key, value);
  }
  return json;
}

/// Update the Json object with a map of key-value pairs.
Json update(V)(Json json, V[string] values) {
  if (!json.isObject) {
    return json;
  }

  foreach (key, value; values.byKeyValue) {
    json = json.update(key, value);
  }

  return json;
}

Json update(V)(Json json, string[] keys, V value) {
  if (!json.isObject) {
    return json;
  }

  keys.each!(key => json.update(key, value));
  return json;
}

Json update(V)(Json json, string key, V value) {
  return json.isObject && json.hasKey(key)
    ? json.set(key, value) : json;
}