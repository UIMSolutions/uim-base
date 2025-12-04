/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.double_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region path
// #region all
// #region value
bool allDouble(Json json, string[][] paths, double value) {
  return paths.all!(path => json.isDouble(path, value));
}
// #endregion value

// #region noValue
/** 
  * Checks if the given JSON value at the specified path is of double (floating-point number) type.
  *
  * Params:
  *   json = The JSON value to check.
  *   paths = The paths within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified path is a double, `false` otherwise.
  */
bool allDouble(Json json, string[][] paths) {
  return paths.all!(path => json.isDouble(path));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool anyDouble(Json json, string[][] paths, double value) {
  return paths.any!(path => json.isDouble(path, value));
}
// #endregion value

// #region noValue
/** 
  * Checks if the given JSON value at the specified paths is of double (floating-point number) type.
  *
  * Params:
  *   json = The JSON value to check.
  *   paths = The paths within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified paths is a double, `false` otherwise.
  */
bool anyDouble(Json json, string[][] paths) {
  return paths.any!(path => json.isDouble(path));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isDouble(Json json, string[] path, double value) {
  return json.isDouble(path) && json.getDouble(path) == value;
}
// #endregion value

// #region noValue
/** 
  * Checks if the given JSON value at the specified path is of double (floating-point number) type.
  *
  * Params:
  *   json = The JSON value to check.
  *   path = The path within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified path is a double, `false` otherwise.
  */
bool isDouble(Json json, string[] path) {
  if (!json.hasPath(path)) {
    return false;
  }

  if (path.length == 1) {
    return json.isDouble(path[0]);
  }

  return json[path[0]].isDouble(path[1 .. $]);
}
// #endregion noValue
// #endregion is
// #endregion path

// #region key
// #region all
// #region value
/** 
  * Checks if the given JSON value at the specified keys is of double (floating-point number) type and matches the given value.
  *
  * Params:
  *   json = The JSON value to check.
  *   keys = The keys within the JSON object to check.
  *   value = The double value to match.
  *
  * Returns:
  *   `true` if the JSON value at the specified keys is a double and matches the given value, `false` otherwise.
  */
bool allDouble(Json json, string[] keys, double value) {
  return keys.any!(key => json.isDouble(key) && json.getDouble(key) == value);
}
// #endregion value

// #region noValue
/** 
  * Checks if the given JSON value at the specified keys is of double (floating-point number) type.
  *
  * Params:
  *   json = The JSON value to check.
  *   keys = The keys within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified keys is a double, `false` otherwise.
  */
bool allDouble(Json json, string[] keys) {
  return keys.any!(key => json.isDouble(key));
}
// #endregion noValue
// #endregion all

// #region any
// #region value
bool anyDouble(Json json, string[] keys, double value) {
  return keys.any!(key => json.isDouble(key, value));
}
// #endregion value

// #region noValue
/** 
  * Checks if the given JSON value at the specified keys is of double (floating-point number) type.
  *
  * Params:
  *   json = The JSON value to check.
  *   keys = The keys within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified keys is a double, `false` otherwise.
  */
bool anyDouble(Json json, string[] keys) {
  return keys.any!(key => json.isDouble(key));
}
// #endregion noValue
// #endregion any

// #region is
// #region value
bool isDouble(Json json, string key, double value) {
  return json.isDouble(key) && json.getDouble(key) == value;
}
// #endregion value

// #region noValue
/** 
  * Checks if the given JSON value at the specified key is of double (floating-point number) type.
  *
  * Params:
  *   json = The JSON value to check.
  *   key  = The key within the JSON object to check.
  *
  * Returns:
  *   `true` if the JSON value at the specified key is a double, `false` otherwise.
  */
bool isDouble(Json value, string key) {
  return (value.type == Json.Type.float_);
}
// #endregion noValue
// #endregion is
// #endregion key

// #region scalar
// #region value
/** 
  * Checks if the given JSON value is of double (floating-point number) type and matches the given value.
  *
  * Params:
  *   json = The JSON value to check.
  *   value = The double value to match.
  *
  * Returns:
  *   `true` if the JSON value is a double and matches the given value, `false` otherwise.
  */
bool isDouble(Json json, double value) {
  return json.isDouble && json.getDouble == value ;
}
// #endregion value

// #region noValue
/** 
  * Checks if the given JSON value is of double (floating-point number) type.
  *
  * Params:
  *   value = The JSON value to check.
  *
  * Returns:
  *   `true` if the JSON value is a double, `false` otherwise.
  */
bool isDouble(Json json) {
  return (json.type == Json.Type.float_);
}
///
unittest {
  // Test with float value
  Json floatVal = Json(3.14);
  assert(floatVal.isDouble);

  // Test with integer value
  Json intVal = Json(42);
  assert(!intVal.isDouble);

  // Test with boolean value
  Json boolVal = Json(true);
  assert(!boolVal.isDouble);

  // Test with string value
  Json strVal = Json("test");
  assert(!strVal.isDouble);

  // Test with null value
  Json nullVal = Json.init;
  assert(!nullVal.isDouble);

  // Test with array value
  Json arrVal = Json.emptyArray;
  assert(!arrVal.isDouble);

  // Test with object value
  Json objVal = Json.emptyObject;
  assert(!objVal.isDouble);
}
// #endregion noValue

// #region get
/**
  * Retrieves the double value from the given JSON at the specified index, key, or directly.
  * If the value is not a double, returns the provided default value.
  *
  * Params:
  *   json = The JSON value to retrieve from.
  *   index = The index within the JSON array.
  *   key = The key within the JSON object.
  *   defaultValue = The default double value to return if the JSON value is not a double.
  *
  * Returns:
  *   The double value from the JSON or the default value if not a double.
  */
double getDouble(Json json, size_t index, double defaultValue = 0.0) {
  return json.isDouble(index) ? json[index].get!(double) : defaultValue;
}

double getDouble(Json json, string key, double defaultValue = 0.0) {
  return json.isDouble(key) ? json[key].get!(double) : defaultValue;
}

double getDouble(Json json, double defaultValue = 0.0) {
  return json.isDouble ? json.get!(double) : defaultValue;
}
// #endregion get
// #endregion scalar
