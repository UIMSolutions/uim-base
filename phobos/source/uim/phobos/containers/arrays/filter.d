module uim.phobos.containers.arrays.filter;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

T[] filterValues(T)(T[] values, bool delegate(T value) check) {
  T[] results;
  () @trusted { results = values.filter!(value => check(value)).array; }();
  return results;
}

T[] filterValues(T)(T[] baseArray, T[] values) {
  return values.length == 0
    ? baseArray : baseArray.filter!(item => values.has(item)).array;
}

/// 
unittest {
  // Test filterValues with delegate
  int[] arr = [1, 2, 3, 4, 5];
  auto even = filterValues(arr, (int v) => v % 2 == 0);
  assert(even == [2, 4]);

  auto greaterThanThree = filterValues(arr, (int v) => v > 3);
  assert(greaterThanThree == [4, 5]);

  auto none = filterValues(arr, (int v) => false);
  assert(none.length == 0);

  auto all = filterValues(arr, (int v) => true);
  assert(all == arr);

  // Test filterValues with baseArray and values
  int[] base = [10, 20, 30, 40, 50];
  int[] vals = [20, 40];
  auto filtered = filterValues(base, vals);
  assert(filtered == [20, 40]);

  auto emptyVals = filterValues(base, []);
  assert(emptyVals == base);

  auto noMatch = filterValues(base, [99, 100]);
  assert(noMatch.length == 0);

  auto allMatch = filterValues(base, base);
  assert(allMatch == base);

  // Test with strings
  string[] words = ["apple", "banana", "cherry"];
  auto filteredWords = filterValues(words, (string w) => w.startsWith("b"));
  assert(filteredWords == ["banana"]);

  auto filterByList = filterValues(words, ["banana", "cherry"]);
  assert(filterByList == ["banana", "cherry"]);
}
