module uim.root.datatypes.jsons.helper;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:


// #region values
Json[] filterValues(Json json) {
  if (json.isNull) {
    return null;
  }

  if (json.isArray) {
    return uim.root.containers.arrays.filter.filterValues(json.get!(Json[]));
  }
  if (json.isObject) {
    return uim.root.containers.maps.filter.filterValues(json.get!(Json[string]));
  }
  return [json];
}
// #endregion values

Json[] filterArrays(Json json) {
  if (json.isArray) {
    return uim.root.containers.arrays.filter.filterArrays(json.toArray);
  }
  if (json.isObject) {
    return uim.root.containers.maps.filter.filterArrays(json.toMap);
  }
  return null;
}

/* 
// #region boolean
bool isAllBoolean(Json json) {
  if (json.isObject) {
    return uim.root.datatypes.jsons.maps.types.booleans.is_.isAllBoolean(json.getObject);
  }
  if (json.isArray) {
    return uim.root.datatypes.jsons.arrays.types.booleans.is_.isAllBoolean(json.getArray);
  }
  return json.isBoolean;
}

bool isAnyBoolean(Json json) {
  if (json.isObject) {
    return uim.root.datatypes.jsons.maps.types.booleans.is_.isAnyBoolean(json.getObject);
  }
  if (json.isArray) {
    return uim.root.datatypes.jsons.arrays.types.booleans.is_.isAnyBoolean(json.getArray);
  }
  return json.isBoolean;
}
// #endregion boolean

// #region integer
bool isAllInteger(Json json) {
  if (json.isObject) {
    return uim.root.datatypes.jsons.maps.types.integers.is_.isAllInteger(json.getObject);
  }
  if (json.isArray) {
    return uim.root.datatypes.jsons.arrays.types.integers.is_.isAllInteger(json.getArray);
  }
  return json.isInteger;
}

bool isAnyInteger(Json json) {
  if (json.isObject) {
    return uim.root.datatypes.jsons.maps.types.integers.is_.isAnyInteger(json.getObject);
  }
  if (json.isArray) {
    return uim.root.datatypes.jsons.arrays.types.integers.is_.isAnyInteger(json.getArray);
  }
  return json.isInteger;
}
// #endregion integer

// #region double
bool isAllDouble(Json json) {
  if (json.isObject) {
    return uim.root.datatypes.jsons.maps.types.doubles.is_.isAllDouble(json.getObject);
  }
  if (json.isArray) {
    return uim.root.datatypes.jsons.arrays.types.doubles.is_.isAllDouble(json.getArray);
  }
  return json.isDouble;
}

bool isAnyDouble(Json json) {
  if (json.isObject) {
    return uim.root.datatypes.jsons.maps.types.doubles.is_.isAnyDouble(json.getObject);
  }
  if (json.isArray) {
    return uim.root.datatypes.jsons.arrays.types.doubles.is_.isAnyDouble(json.getArray);
  }
  return json.isDouble;
}
// #endregion double

// #region string
bool isAllString(Json json) {
  if (json.isObject) {
    return uim.root.datatypes.jsons.maps.types.strings.is_.isAllString(json.getObject);
  }
  if (json.isArray) {
    return uim.root.datatypes.jsons.arrays.types.strings.is_.isAllString(json.getArray);
  }
  return json.isString;
}

bool isAnyString(Json json) {
  if (json.isObject) {
    return uim.root.datatypes.jsons.maps.types.strings.is_.isAnyString(json.getObject);
  }
  if (json.isArray) {
    return uim.root.datatypes.jsons.arrays.types.strings.is_.isAnyString(json.getArray);
  }
  return json.isString;
}
// #endregion string

// #region object
bool isAllObject(Json json) {
  if (json.isObject) {
    return uim.root.datatypes.jsons.maps.is_.isAllObject(json.getObject);
  }
  if (json.isArray) {
    return uim.root.datatypes.jsons.arrays.types.objects.isAllObject(json.getArray);
  }
  return json.isObject;
}

bool isAnyObject(Json json) {
  if (json.isObject) {
    return uim.root.datatypes.jsons.maps.is_.isAnyObject(json.getObject);
  }
  if (json.isArray) {
    return uim.root.datatypes.jsons.arrays.types.objects.isAnyObject(json.getArray);
  }
  return json.isObject;
}
// #endregion string

*/