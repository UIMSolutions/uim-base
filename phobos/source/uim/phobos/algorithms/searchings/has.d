/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.algorithms.searchings.has;

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
bool has(T)(T[] values, T value) {
  if (values is null) {
    return false; // Handle null array case
  }
  return values.any!(v => v == value);
}

unittest {
  // Test with an empty array
  assert(!has!int(null, 1));

  // Test with a single element array
  assert(has([1], 1));
  assert(!has([1], 2));

  // Test with multiple elements
  assert(has([1, 2, 3], 2));
  assert(!has([1, 2, 3], 4));

  // Test with repeated elements
  assert(has([1, 2, 2, 3], 2));

  // Test with strings
  assert(has(["a", "b", "c"], "b"));
  assert(!has(["a", "b", "c"], "d"));

  // Test with characters
  assert(has(['a', 'b', 'c'], 'b'));
}
