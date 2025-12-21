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
  indices.sort!("b>a")
    .each!(index => list.remove(index));
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

Json[] removeArrays(Json[] items, bool delegate(Json json) @safe removeFunc) {
  return items.filter!(json => !foundArray(json, removeFunc)).array;
}

Json[] removeArrays(Json[] items, size_t[] indices) {
  return items.filter!((item, index) => !indices.hasValue(index) || !items.isArray(index)).array;
}

Json[] removeArrays(Json[] items) {
  return items.remove!(item => item.isArray).array;
}

protected bool foundArray(Json json, bool delegate(Json value) removeFunc) {
  bool found = false;
  () @trusted { found = json.isArray && json.removeFunc; }();
  return found;
}
