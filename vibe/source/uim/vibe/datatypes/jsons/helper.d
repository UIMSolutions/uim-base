module uim.vibe.datatypes.jsons.helper;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region integer
bool allInteger(Json json) {
  if (json.isObject) {
    return allInteger(json.to!(Json[string]));
  }
  if (json.isArray) {
    return allInteger(json.to!(Json[]));
  }
  return json.isInteger;
}

bool anyInteger(Json json) {
  if (json.isObject) {
    return anyInteger(json.to!(Json[string]));
  }
  if (json.isArray) {
    return anyInteger(json.to!(Json[]));
  }
  return json.isInteger;
}
// #endregion integer

// #region string
bool allString(Json json) {
  if (json.isObject) {
    return allString(json.to!(Json[string]));
  }
  if (json.isArray) {
    return allString(json.to!(Json[]));
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