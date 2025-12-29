/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.doubles.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

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
double getDoubleByIndex(Json json, size_t index, double defaultValue = 0.0) {
  return json.isDouble(index) ? json[index].getDouble(defaultValue) : defaultValue;
}

double getDoubleByKey(Json json, string key, double defaultValue = 0.0) { 
  return json.isDouble(key) ? json[key].getDouble(defaultValue) : defaultValue;
}

double getDouble(Json value, double defaultValue = 0.0) {
  return value.isDouble 
    ? value.get!(double) : defaultValue;
}
