/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.containers.sequential.arrays.reverse;

import uim.root;

mixin(Version!("test_uim_phobos"));

@safe:

T[] reverse(T)(T[] items) {
  T[] results;
  foreach_reverse(item; items) {
    results ~= item;
  }
  return results;
}
///
unittest {
  auto test1 = [1, 2, 3, 4, 5];
  assert(test1.reverse() == [5, 4, 3, 2, 1]);

  auto test2 = ["a", "b", "c", "d"];
  assert(test2.reverse() == ["d", "c", "b", "a"]);
}