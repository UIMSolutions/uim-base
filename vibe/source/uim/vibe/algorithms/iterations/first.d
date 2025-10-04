/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.algorithms.iterations.first;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

T first(T)(T[] values) {
  return (values.length > 0) 
    ? values[0]
    : Null!T;  
}

unittest {
  int[] arr = [10, 20, 30];
  assert(first(arr) == 10);
  
  int[] emptyArr;
  assert(first(emptyArr) is null);
}