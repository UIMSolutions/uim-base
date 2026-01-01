module uim.root.containers.sequential.arrays.aggregate;

import uim.root;

mixin(Version!("test_uim_phobos"));

@safe:

/*
auto aggregate(T, OUT)(T[] items, OUT delegate(ref OUT aggregate, in T item) aggregator, OUT initialValue) {
  OUT result = initialValue;
  foreach (item; items) {
    aggregator(result, item);
  }
  return result;
}
/// 
unittest {
    auto items = [1, 2, 3, 4, 5];
    auto sum = aggregate!int(items, (ref int agg, in int item) @safe {
        agg += item;
    }, 0);
    assert(sum == 15);
}
*/