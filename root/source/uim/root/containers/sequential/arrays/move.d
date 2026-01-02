/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.containers.sequential.arrays.move;

import uim.root;

mixin(Version!("test_uim_phobos"));

@safe:

// #region forward
void moveForward(T)(T[] values, size_t fromIndex, size_t toIndex) {
  auto result = values.dup;

  if (fromIndex >= result.length || toIndex >= result.length || fromIndex >= toIndex) {
    return;
  }
  auto temp = result[fromIndex];
  for (size_t i = fromIndex; i < toIndex; i++) {
    result[i] = result[i + 1];
  }
  result[toIndex] = temp;
  return result;
}
// #endregion forward

// #region backward
void moveBackward(T)(ref T[] values, size_t fromIndex, size_t toIndex) {
  auto result = values.dup;

  if (fromIndex >= result.length || toIndex >= result.length || fromIndex <= toIndex) {
    return;
  }
  auto temp = result[fromIndex];
  for (size_t i = fromIndex; i > toIndex; i--) {
    result[i] = result[i - 1];
  }
  result[toIndex] = temp;
  return result;
}
// #endregion backward
