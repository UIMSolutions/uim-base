module uim.vibe.datatypes.jsons.helper;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region integer
bool isAllInteger(Json json) {
  if (json.isObject) {
    return isAllInteger(json.to!(Json[string]));
  }
  if (json.isArray) {
    return isAllInteger(json.to!(Json[]));
  }
  return json.isInteger;
}

bool isAnyInteger(Json json) {
  if (json.isObject) {
    return isAnyInteger(json.to!(Json[string]));
  }
  if (json.isArray) {
    return isAnyInteger(json.to!(Json[]));
  }
  return json.isInteger;
}
// #endregion integer

// #region string
bool isAllString(Json json) {
  if (json.isObject) {
    return isAllString(json.to!(Json[string]));
  }
  if (json.isArray) {
    return isAllString(json.to!(Json[]));
  }
  return json.isString;
}

bool isAnyString(Json json) {
  if (json.isObject) {
    return isAnyString(json.to!(Json[string]));
  }
  if (json.isArray) {
    return isAnyString(json.to!(Json[]));
  }
  return json.isString;
}
// #endregion string