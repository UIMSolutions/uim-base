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