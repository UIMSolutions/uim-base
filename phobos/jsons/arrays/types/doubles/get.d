/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.doubles.get;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

double getDoubleByIndex(Json[] jsons, size_t index, double defaultValue = 0.0) {
  return jsons.length > index && jsons[index].isDouble
    ? getDouble(jsons[index], defaultValue) : defaultValue;
}
