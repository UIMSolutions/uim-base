/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.objects.get;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region get
Json[string] getObjectByIndex(Json[] jsons, size_t index, Json[string] defaultValue = null) {
  return jsons.length > index && jsons[index].isObject ? jsons[index].getObject(defaultValue) : defaultValue;
}
// #endregion get