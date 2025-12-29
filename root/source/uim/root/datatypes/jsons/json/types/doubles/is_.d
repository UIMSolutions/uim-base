/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.doubles.is_;

import uim.root;

mixin(Version!("test_uim_root"));

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
 return json.getPath(path).isDouble;
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
// #endregion noValue
// #endregion is
// #endregion key

