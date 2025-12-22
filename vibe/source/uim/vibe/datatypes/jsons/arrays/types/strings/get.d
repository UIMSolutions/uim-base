/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.strings.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

string[] getStringArray(Json[] jsons, size_t[] indices, string defaultValue = null) {
  return jsons
    .getValues(indices)
    .filterStrings
    .getStringArray(defaultValue);
}

string[] getStringArray(Json[] jsons, string defaultValue = null) {
  return jsons
    .filter!(value => value.isString)
    .map!(value => value.get!string)
    .array;
}

string[] toStringArray(Json[] jsons, string defaultValue = null) {
  return jsons.map!(value => value.to!string).array;
}

string getStringByIndex(Json[] jsons, size_t index, string defaultValue = null) {
  return jsons.length > index && jsons[index].isString ? jsons[index].getString(defaultValue) : defaultValue;
}
