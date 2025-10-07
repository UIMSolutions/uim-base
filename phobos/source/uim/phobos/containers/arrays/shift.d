module uim.phobos.containers.arrays.shift;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

// #region shift
/**
 * Shifts the elements of an array by a specified number of positions.
 *
 * This function modifies the input array in place by shifting its elements
 * to the right by the given number of positions. Elements that are shifted
 * beyond the end of the array wrap around to the beginning.
 *
 * Params:
 *     values = The array to be shifted. This array is modified in place.
 *     times = The number of positions to shift the elements. If `times` is
 *             greater than the length of the array, it wraps around using
 *             modulo arithmetic.
 *
 * Returns:
 *     The modified array after the shift operation.
 *
 * Example:
 *     int[] arr = [1, 2, 3, 4];
 *     arr.shift(2);
 *     // arr is now [3, 4, 1, 2]
 */
T[] shiftMany(T)(ref T[] values, size_t times = 1) {
  T[] results = [];

  if (values.length == 0) {
    return results;
  }

  if (times >= values.length) {
    results = values.dup;
    values = [];
    return results;
  }

  results = values[0 .. times];
  values = values[times .. $].dup;
  return results;
}

T shift(T)(ref T[] values) {
  if (values.length == 0) {
    return T.init;
  }

  // values.length > 0
  T value = values[0];
  values = values.length == 1
    ? [] : values[1 .. $];

  return value;
}

unittest {
  // Test shiftMany with normal case
  int[] arr1 = [1, 2, 3, 4, 5];
  auto shifted1 = shiftMany(arr1, 2);
  assert(shifted1.equal([1, 2]));
  assert(arr1.equal([3, 4, 5]));

  // Test shiftMany with times = 0
  int[] arr2 = [10, 20, 30];
  auto shifted2 = shiftMany(arr2, 0);
  assert(shifted2.equal([]));
  assert(arr2.equal([10, 20, 30]));

  // Test shiftMany with times >= length
  int[] arr3 = [7, 8, 9];
  auto shifted3 = shiftMany(arr3, 5);
  assert(shifted3.equal([7, 8, 9]));
  assert(arr3.length == 0);

  // Test shiftMany with empty array
  int[] arr4 = [];
  auto shifted4 = shiftMany(arr4, 1);
  assert(shifted4.length == 0);
  assert(arr4.length == 0);

  // Test shift default times = 1
  int[] arr5 = [42, 43, 44];
  auto shifted5 = shiftMany(arr5);
  assert(shifted5.equal([42]));
  assert(arr5.equal([43, 44]));

  // Test shift with single element
  int[] arr6 = [99];
  auto val6 = shift(arr6);
  assert(val6 == 99);
  assert(arr6.length == 0);

  // Test shift with empty array
  int[] arr7 = [];
  auto val7 = shift(arr7);
  assert(val7 == int.init);
  assert(arr7.length == 0);

  // Test shift repeatedly
  int[] arr8 = [1, 2, 3];
  auto v1 = shift(arr8);
  auto v2 = shift(arr8);
  auto v3 = shift(arr8);
  assert(v1 == 1 && v2 == 2 && v3 == 3);
  assert(arr8.length == 0);

  writeln("All shift and shiftMany tests passed.");
}
// #endregion shift
