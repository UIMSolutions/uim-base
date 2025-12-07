module uim.vibe.datatypes.jsons.helper;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region integer
bool isAllInteger(Json json) {
  if (json.isObject) {
    return isAllInteger(json.getObject);
  }
  if (json.isArray) {
    return isAllInteger(json.getArray);
  }
  return json.isInteger;
}

bool isAnyInteger(Json json) {
  if (json.isObject) {
    return isAnyInteger(json.getObject);
  }
  if (json.isArray) {
    return isAnyInteger(json.getArray);
  }
  return json.isInteger;
}
// #endregion integer

// #region string
bool isAllString(Json json) {
  if (json.isObject) {
    return isAllString(json.getObject);
  }
  if (json.isArray) {
    return isAllString(json.getArray);
  }
  return json.isString;
}

bool isAnyString(Json json) {
  if (json.isObject) {
    return isAnyString(json.getObject);
  }
  if (json.isArray) {
    return isAnyString(json.getArray);
  }
  return json.isString;
}
// #endregion string