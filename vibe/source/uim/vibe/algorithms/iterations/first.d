module uim.vibe.algorithms.iterations.first;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

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