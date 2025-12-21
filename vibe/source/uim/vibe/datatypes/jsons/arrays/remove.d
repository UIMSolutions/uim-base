/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] clear(Json[] list) {
  list = [];
  return list;
}

Json[] remove(Json[] list, size_t[] indices) {
  indices.sort!("b>a").each!(index => list.remove(index));
  return list;
}

Json[] remove(Json[] list, size_t index) {
  if (list.length == 0) {
    return list;
  }

  if (list.length > index) {
    list.remove(index);
  }
  return list;
}



// #region arrays
Json[] removeArrays(Json[] items, bool delegate(Json json) @safe removeFunc) {
  return items.removeArrays.removeValues(removeFunc);
}

Json[] removeArrays(Json[] items, size_t[] indices) {
  return items.removeIndices(indices).removeArrays.array;
}

Json[] removeArrays(Json[] items) {
  return items.remove!(item => item.isArray).array;
}
// #endregion arrays