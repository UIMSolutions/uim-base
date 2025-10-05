/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.algorithms.searchings.has_;

import uim.phobos;

@safe:

/**
 * Checks if a value exists in an array.
 *
 * This function returns true if the specified value is found in the array,
 * otherwise it returns false.
 *
 * Params:
 *     values - The array of values to search through.
 *     value - The value to check for in the array.
 *
 * Returns:
 *     true if `value` is found in `values`, false otherwise.
 */
bool hasKey(T)(T[] values, T value) {
  if (values is null) {
    return false; // Handle null array case
  }
  return values.any!(v => v == value);
}

unittest {
  // Test with a single element array
  assert(hasKey([1], 1));
  assert(!hasKey([1], 2));

  // Test with multiple elements
  assert(hasKey([1, 2, 3], 2));
  assert(!hasKey([1, 2, 3], 4));

  // Test with repeated elements
  assert(hasKey([1, 2, 2, 3], 2));

  // Test with strings
  assert(hasKey(["a", "b", "c"], "b"));
  assert(!hasKey(["a", "b", "c"], "d"));

  // Test with characters
  assert(hasKey(['a', 'b', 'c'], 'b'));
}
