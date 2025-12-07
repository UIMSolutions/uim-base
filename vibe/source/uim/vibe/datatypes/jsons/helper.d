module uim.vibe.datatypes.jsons.helper;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region boolean
bool isAllBoolean(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.booleans.isAllBoolean(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.booleans.isAllBoolean(json.getArray);
  }
  return json.isBoolean;
}

bool isAnyBoolean(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.booleans.isAnyBoolean(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.booleans.isAnyBoolean(json.getArray);
  }
  return json.isBoolean;
}
// #endregion boolean

// #region integer
bool isAllInteger(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.integers.isAllInteger(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.integers.isAllInteger(json.getArray);
  }
  return json.isInteger;
}

bool isAnyInteger(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.integers.isAnyInteger(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.integers.isAnyInteger(json.getArray);
  }
  return json.isInteger;
}
// #endregion integer

// #region double
bool isAllDouble(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.doubles.isAllDouble(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.doubles.isAllDouble(json.getArray);
  }
  return json.isDouble;
}

bool isAnyDouble(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.doubles.isAnyDouble(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.doubles.isAnyDouble(json.getArray);
  }
  return json.isDouble;
}
// #endregion double

// #region string
bool isAllString(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.strings.isAllString(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.strings.isAllString(json.getArray);
  }
  return json.isString;
}

bool isAnyString(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.strings.isAnyString(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.strings.isAnyString(json.getArray);
  }
  return json.isString;
}
// #endregion string

// #region object
bool isAllObject(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.is_.isAllObject(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.objects.isAllObject(json.getArray);
  }
  return json.isObject;
}

bool isAnyObject(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.is_.isAnyObject(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.objects.isAnyObject(json.getArray);
  }
  return json.isObject;
}
// #endregion string