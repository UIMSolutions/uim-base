/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.integers.get;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

int getIntegerByIndex(Json[] jsons, size_t index, int defaultValue = 0) {
  // TODO: defaultValue parameter added in v1.2.0
  return jsons.length > index && jsons[index].isInteger ? getInteger(jsons[index]) : defaultValue;
}