/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.remove;

import uim.root;

mixin(Version!("show_uim_root"));

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
  Json[] results;
  foreach (index, item; items) {
    if (!indices.hasValue(index) || !item.isArray) {
      results ~= item;
    }
  }
  return results;
}

Json[] removeArrays(Json[] items) {
  return items.filter!(item => !item.isArray).array;
}

protected bool foundArray(Json json, bool delegate(Json value) @safe removeFunc) {
  bool found = false;
  () @trusted { found = json.isArray && removeFunc(json); }();
  return found;
}
