/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.strings.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

string[] getStringArray(Json[] jsons, size_t[] indices, string defaultValue = null) {
  return jsons.filterValues(indices).filterStrings
    .getStringArray(defaultValue);
}

string[] getStringArray(Json[] jsons, string defaultValue = null) {
  return jsons.filterStrings
    .map!(value => value.get!string)
    .array;
}

string getStringByIndex(Json[] jsons, size_t index, string defaultValue = null) {
  import uim.root.datatypes.jsons.typecheck;
  return jsons.length > index && jsons[index].isString ? jsons[index].getString(defaultValue) : defaultValue;
}
