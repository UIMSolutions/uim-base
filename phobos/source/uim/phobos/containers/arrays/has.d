/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.containers.arrays.has;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

/**
 * Checks if the given value exists within the provided array.
 *
 * Params:
 *   values = The array to search.
 *   value = The value to look for in the array.
 *
 * Returns:
 *   `true` if the value is found in the array, `false` otherwise.
 */
bool has(T)(T[] values, T value) {
  return values.canFind(value);
}

unittest {
  // Test with int array
  int[] arrInt = [1, 2, 3, 4, 5];
  assert(has(arrInt, 3));
  assert(!has(arrInt, 6));

  // Test with string array
  string[] arrStr = ["apple", "banana", "cherry"];
  assert(has(arrStr, "banana"));
  assert(!has(arrStr, "date"));

  // Test with empty array
  int[] emptyArr;
  assert(!has(emptyArr, 1));

  // Test with custom type
  struct Point {
    int x, y;
  }

  Point[] points = [Point(1, 2), Point(3, 4)];
  assert(has(points, Point(1, 2)));
  assert(!has(points, Point(5, 6)));
}
