mo/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
moduledule uim.vibe.datatypes.jsons.arrays.types.objects.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
Json[string] getObject(Json[] jsons, size_t index, Json[string] defaultValue = null) {
  return jsons.length > index && jsons[index].isObject ? jsons[index].getObject(defaultValue) : defaultValue;
}
// #endregion get