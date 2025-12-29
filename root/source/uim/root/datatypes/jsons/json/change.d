module uim.root.datatypes.jsons.json.change;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

/** 
  * Update the Json object with another Json object.
  *
  * Params:
  *   json = The JSON object to update.
  *   map = The JSON object containing key-value pairs to set in the original JSON object.
  *
  * Returns:
  *   The updated JSON object.
  */
Json update(Json json, Json map) {
  if (!json.isObject || !map.isObject) {
    return json;
  }

  foreach (key, value; map.byKeyValue) {
    json = json.update(key, value);
  }
  return json;
}

/** 
  * Update the Json object with a string-keyed associative array.
  *
  * Params:
  *   json = The JSON object to update.
  *   values = An associative array of string keys and values to set in the JSON object.
  *
  * Returns:
  *   The updated JSON object.
  */
Json update(V)(Json json, V[string] values) {
  if (!json.isObject) {
    return json;
  }

  foreach (key, value; values.byKeyValue) {
    json = json.update(key, value);
  }

  return json;
}

/** 
  * Update the Json object at the specified keys with the given value.
  *
  * Params:
  *   json = The JSON object to update.
  *   keys = An array of keys representing the keys to update.
  *   value = The value to set at the specified keys.
  *
  * Returns:
  *   The updated JSON object.
  */
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