module uim.vibe.datatypes.json.objects.isobject;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

bool isAllObject(Json json) {
  if (json.isArray) {
    return json.toArray.isAllObject;
  }
  if (json.isObject) {
    return json.byValue.array.isAllObject;
  }
  return json.isObject;
}

bool isAllObject(Json[] values) {
  return values.all!(value => value.isObject);
}

bool isAnyObject(Json json) {
  if (json.isArray) {
    return json.toArray.isAnyObject;
  }
  if (json.isObject) {
    return json.byValue.array.isAnyObject;
  }
  return json.isObject;
}

bool isAnyObject(Json[string] values) {
  return values.byValue.array.isAnyObject;
}

bool isAnyObject(Json[] values) {
  return values.any!(value => value.isObject);
}

// Check if the JSON value is an object
bool isObject(Json json) {
  return json.type == Json.Type.object;
}

bool isObject(Json json, string key) {
  return json.hasKey(key)
  ? json[key].isObject : false;
}

bool isObject(Json[string] map, string key) {
  return map.hasKey(key)
  ? map[key].isObject : false;
}