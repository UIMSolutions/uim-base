/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.algorithm.searching;

import uim.phobos;

@safe:

// #region positions
// Creates a associative array with all positions of a value in an array
size_t[][T] positions(T)(T[] list) {
  size_t[][T] results;
  foreach (pos, v; list) {
    if (v in results) {
      results[v] ~= pos;
    } else {
      results[v] = [pos];
    }
  }
  return results;
}

unittest {
  // Test with an empty array
  assert(positions!int(null) == null);

  // Test with a single element array
  assert(positions([1]) == [1: [0UL]]);

  // Test with repeated elements
  assert(positions([1, 1]) == [1: [0UL, 1UL]]);

  // Test with multiple distinct elements
  assert(positions([1, 2]) == [1: [0UL], 2: [1UL]]);

  // Test with mixed repeated and distinct elements
  assert(positions([1, 2, 1, 3, 2]) == [1: [0UL, 2UL], 2: [1UL, 4UL], 3: [3UL]]);

  // Test with strings
  assert(positions(["a", "b", "a", "c", "b"]) == [
      "a": [0UL, 2UL],
      "b": [1UL, 4UL],
      "c": [3UL]
    ]);

  // Test with an array of characters
  assert(positions(['a', 'b', 'a', 'c', 'b']) == [
      'a': [0UL, 2UL],
      'b': [1UL, 4UL],
      'c': [3UL]
    ]);

  // Test with floating-point numbers
  assert(positions([1.1, 2.2, 1.1, 3.3]) == [
      1.1: [0UL, 2UL],
      2.2: [1UL],
      3.3: [3UL]
    ]);
}
// #endregion positions

// #region duplicates
size_t[T] duplicates(T)(in T[] someValues) {
  size_t[T] results;
  someValues
    .filter!(value => duplicates(someValues, value) > 0)
    .each!(value => results[value] = duplicates(someValues, value));

  return results;
}


/**
 * Counts the number of occurrences of a specific value within an array.
 *
 * This function iterates through the given array and returns the count of
 * elements that match the specified value.
 *
 * Params:
 *     values - The array of values to search through.
 *     value - The value to count within the array.
 *
 * Returns:
 *     The number of times `value` appears in `someValues`.
 *
 * Example:
 *     auto arr = [1, 2, 3, 2, 4];
 *     assert(duplicates(arr, 2) == 2);
 */
size_t duplicates(T)(T[] values, T search) {
  auto result = values.filter!(value => value == search).count;
  return result > 1 ? result - 1 : 0;
}

unittest {
  // Test with an empty array
  assert(duplicates!int([], 1) == 0);

  // Test with a single element array
  assert(duplicates([1], 1) == 0);

  // Test with no duplicates
  assert(duplicates([1, 2, 3], 2) == 0);

  // Test with one duplicate
  assert(duplicates([1, 2, 2, 3], 2) == 1);

  // Test with multiple duplicates
  assert(duplicates([1, 2, 2, 2, 3], 2) == 2);

  // Test with a value not in the array
  assert(duplicates([1, 2, 3], 4) == 0);

  // Test with strings
  assert(duplicates(["a", "b", "a", "c"], "a") == 1);
  assert(duplicates(["a", "b", "c"], "d") == 0);

  // Test with characters
  assert(duplicates(['a', 'b', 'a', 'c'], 'a') == 1);
  assert(duplicates(['a', 'b', 'c'], 'd') == 0);

  // Test with floating-point numbers
  assert(duplicates([1.1, 2.2, 1.1, 3.3], 1.1) == 1);
  assert(duplicates([1.1, 2.2, 3.3], 4.4) == 0);
}
// #endregion duplicates
