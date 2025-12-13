module uim.vibe.datatypes.jsons.helper;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasAnyBoolean(Json json) {
  if (json.isArray) {
    return json.toArray.hasAnyBoolean;
  }

  if (json.isObject) {
    return json.toObject.hasAnyBoolean;
  }

  return json.isBoolean;
}

// #region values
Json[] filterValues(Json json) {
  if (json.isNull) {
    return null;
  }

  if (json.isArray) {
    return uim.vibe.containers.arrays.filter.filterValues(json.get!(Json[]));
  }
  if (json.isObject) {
    return uim.vibe.containers.maps.filter.filterValues(json.get!(Json[string]));
  }
  return [json];
}
// #endregion values

Json[] filterObjects(Json json) {
  if (json.isArray) {
    import uim.vibe.containers.arrays.filter;
    Json[] items = json.toArray;
    return items.length > 0 ? uim.vibe.containers.arrays.filter.filterObjects(items) : null;
  }
  if (json.isObject) {
    import uim.vibe.containers.maps.filter;
    Json[string] items = json.toMap;
    return items.length > 0 ? uim.vibe.containers.maps.filter.filterObjects(items) : null;
  }
  return null;
}

Json[] filterArrays(Json json) {
  if (json.isArray) {
    return uim.vibe.containers.arrays.filter.filterArrays(json.toArray);
  }
  if (json.isObject) {
    return uim.vibe.containers.maps.filter.filterArrays(json.toMap);
  }
  return null;
}

/* 
// #region boolean
bool isAllBoolean(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.booleans.is_.isAllBoolean(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.booleans.is_.isAllBoolean(json.getArray);
  }
  return json.isBoolean;
}

bool isAnyBoolean(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.booleans.is_.isAnyBoolean(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.booleans.is_.isAnyBoolean(json.getArray);
  }
  return json.isBoolean;
}
// #endregion boolean

// #region integer
bool isAllInteger(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.integers.is_.isAllInteger(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.integers.is_.isAllInteger(json.getArray);
  }
  return json.isInteger;
}

bool isAnyInteger(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.integers.is_.isAnyInteger(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.integers.is_.isAnyInteger(json.getArray);
  }
  return json.isInteger;
}
// #endregion integer

// #region double
bool isAllDouble(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.doubles.is_.isAllDouble(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.doubles.is_.isAllDouble(json.getArray);
  }
  return json.isDouble;
}

bool isAnyDouble(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.doubles.is_.isAnyDouble(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.doubles.is_.isAnyDouble(json.getArray);
  }
  return json.isDouble;
}
// #endregion double

// #region string
bool isAllString(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.strings.is_.isAllString(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.strings.is_.isAllString(json.getArray);
  }
  return json.isString;
}

bool isAnyString(Json json) {
  if (json.isObject) {
    return uim.vibe.datatypes.jsons.objects.types.strings.is_.isAnyString(json.getObject);
  }
  if (json.isArray) {
    return uim.vibe.datatypes.jsons.arrays.types.strings.is_.isAnyString(json.getArray);
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

*/