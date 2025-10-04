/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.algorithms.iterations.last;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

T last(T)(T[] values) {
  return (values.length > 0) 
    ? values[$-1]
    : Null!T;  
}

unittest {
  int[] arr = [10, 20, 30];
  assert(last(arr) == 30);
  
  int[] emptyArr;
  assert(last(emptyArr) is null);
}