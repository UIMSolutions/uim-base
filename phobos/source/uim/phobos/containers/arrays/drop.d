module uim.phobos.containers.arrays.drop;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

/** 
    * Drops the first `n` elements from the array `values` and returns the resulting array.
    *
    * Params:
    *   values = The input array from which elements will be dropped.
    *   number = The number of elements to drop from the start of the array.
    *
    * Returns:
    *   A new array with the first `n` elements removed.
    *
    * Example:
    * ```d
    * import uim.phobos.containers.arrays.drop : drop;
    * 
    * auto values = [1, 2, 3, 4, 5];
    * auto result = drop(arr, 2); // result is [3, 4, 5]
    * ```
    */
auto drop(T)(T[] values, size_t number) {
  return number >= values.length
    ? T[].init // Return an empty array if number is greater than or equal to the array length
    : values[number .. $]; // Return the subarray starting from index number to the end
}
///
unittest {
  auto result = drop([1, 2, 3, 4, 5], 2);
  assert(result == [3, 4, 5]);
  assert(drop([1, 2, 3], 0) == [1, 2, 3]);
  assert(drop([1, 2, 3], 3) == []);
  assert(drop([1, 2, 3], 5) == []);
  assert(drop([], 2) == []);
}
