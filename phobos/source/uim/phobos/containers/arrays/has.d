/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.containers.arrays.has;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:


bool hasAll(T)(T[] values, in T[] checkValues...) {
  return values.hasAll(checkValues.dup);
}

unittest {
  // Test hasAll
  int[] arrInt = [1, 2, 3, 4, 5];
  assert(arrInt.hasAll(2, 3));
  assert(!arrInt.hasAll(2, 6));

  string[] arrStr = ["apple", "banana", "cherry"];
  assert(arrStr.hasAll("banana", "cherry"));
  assert(!arrStr.hasAll("banana", "date"));
}

/**
 * Checks if all specified values exist within the provided array.
 *
 * Params:
 *   values  = The array to search.
 *   checkValues = The values to look for in the array.
 *
 * Returns:
 *   `true` if all values are found in the array, `false` otherwise.
 */
bool hasAll(T)(T[] values, in T[] checkValues) {
  return checkValues.all!(value => values.has(value));
}
///
unittest {
  // Test hasAll
  int[] arrInt = [1, 2, 3, 4, 5];
  assert(arrInt.hasAll([2, 3]));
  assert(!arrInt.hasAll([2, 6]));

  string[] arrStr = ["apple", "banana", "cherry"];
  assert(arrStr.hasAll(["banana", "cherry"]));
  assert(!arrStr.hasAll(["banana", "date"]));
}

/**
 * Checks if any of the specified values exist within the provided array.
 *
 * Params:
 *   values  = The array to search.
 *   checkValues = The values to look for in the array.
 *
 * Returns:
 *   `true` if any value is found in the array, `false` otherwise.
 */
bool hasAny(T)(T[] values, in T[] checkValues) {
  return checkValues.any!(value => values.has(value));
}
///
unittest {
  int[] arrInt = [1, 2, 3, 4, 5];
  
  // Test hasAny
  assert(arrInt.hasAny([0, 3, 6]));
  assert(!arrInt.hasAny([0, 6]));

  // Test with string array
  string[] arrStr = ["apple", "banana", "cherry"];
  assert(arrStr.hasAny(["date", "cherry"]));
  assert(!arrStr.hasAny(["date", "fig"]));
}

bool hasAny(T)(T[] values, in T[] checkValues...) {
  return checkValues.any!(value => values.has(value));
}

unittest {
  int[] arrInt = [1, 2, 3, 4, 5];
  
  // Test hasAny
  assert(arrInt.hasAny(0, 3, 6));
  assert(!arrInt.hasAny(0, 6));

  // Test with string array
  string[] arrStr = ["apple", "banana", "cherry"];
  assert(arrStr.hasAny("date", "cherry"));
  assert(!arrStr.hasAny("date", "fig"));
}

/**
 * Checks if the given value exists within the provided array.
 *
 * Params:
 *   values = The array to search.
 *   checkValue = The value to look for in the array.
 *
 * Returns:
 *   `true` if the value is found in the array, `false` otherwise.
 */
bool has(T)(T[] values, T checkValue) {
  return values.canFind(checkValue);
}
///
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
