/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.algorithms.mutations;

import uim.phobos;

@safe:

// #region intersect 
V[K] intersect(K, V)(V[K] map, K[] keys) {
  V[K] results = null;
  foreach (key; keys) {
    if (key in map) {
      results[key] = map[key];
    }
  }
  return results;
}

T[] intersect(T)(T[] list, T[] secondList) {
  T[T] helper;
  foreach (value; secondList) {
    helper[value] = value;
  }

  return list
    .uniq
    .filter!(value => value in helper)
    .map!(value => value)
    .array;
}

unittest {
  // Test 1: Basic functionality with integers
  int[int] map = [1: 10, 2: 20, 3: 30];
  int[] keys = [1, 3];
  auto result = intersect(map, keys);
  assert(result == [1: 10, 3: 30], "Test 1 failed");

  // Test 2: No matching keys
  keys = [4, 5];
  result = intersect(map, keys);
  assert(result == null, "Test 2 failed");

  // Test 3: Partial matching keys
  keys = [2, 4];
  result = intersect(map, keys);
  assert(result == [2: 20], "Test 3 failed");

  // Test 4: Empty map
  int[int] emptyMap;
  keys = [1, 2, 3];
  result = intersect(emptyMap, keys);
  assert(result == null, "Test 4 failed");

  // Test 5: Empty keys
  keys = [];
  result = intersect(map, keys);
  assert(result == null, "Test 5 failed");
}

unittest {
  // Test 1: Basic functionality with integers
  int[] list = [1, 2, 3, 4, 5];
  int[] secondList = [3, 4, 6];
  auto result = intersect(list, secondList);
  assert(result == [3, 4], "Test 1 failed");

  // Test 2: No common elements
  list = [1, 2, 3];
  secondList = [4, 5, 6];
  result = intersect(list, secondList);
  assert(result == null, "Test 2 failed");

  // Test 3: All elements match
  list = [1, 2, 3];
  secondList = [1, 2, 3];
  result = intersect(list, secondList);
  assert(result == [1, 2, 3], "Test 3 failed");

  // Test 4: Empty first list
  list = null;
  secondList = [1, 2, 3];
  result = intersect(list, secondList);
  assert(result == null, "Test 4 failed");

  // Test 5: Empty second list
  list = [1, 2, 3];
  secondList = null;
  result = intersect(list, secondList);
  assert(result == null, "Test 5 failed");

  // Test 6: Duplicate elements in the first list
  list = [1, 2, 2, 3, 3, 3];
  secondList = [2, 3];
  result = intersect(list, secondList);
  assert(result == [2, 3], "Test 6 failed");

  // Test 7: Duplicate elements in the second list
  list = [1, 2, 3];
  secondList = [2, 2, 3, 3];
  result = intersect(list, secondList);
  assert(result == [2, 3], "Test 7 failed");

  // Test 8: Mixed types (e.g., strings)
  string[] strList = ["apple", "banana", "cherry"];
  string[] strSecondList = ["banana", "cherry", "date"];
  auto strResult = intersect(strList, strSecondList);
  assert(strResult == ["banana", "cherry"], "Test 8 failed");
}
// #endregion intersect 

// #region change positions
// Changes positions
void change(T)(auto ref T left, ref T right) {
  T buffer = left;
  left = right;
  right = buffer;
}

/// Changs positions of elements in array
T[] change(T)(T[] items, size_t posLeft, size_t posRight) {
  if ((posLeft == posRight) || (posLeft >= items.length) || (posRight >= items.length) || (
      posLeft == posRight)) {
    return items;
  }

  T buffer = items[posLeft];
  items[posLeft] = items[posRight];
  items[posRight] = buffer;
  return items;
}

unittest {
  // Test 1: Swap two integers
  int a = 5;
  int b = 10;
  change(a, b);
  assert(a == 10 && b == 5, "Test 1 failed");

  // Test 2: Swap two floating-point numbers
  double x = 3.14;
  double y = 2.71;
  change(x, y);
  assert(x == 2.71 && y == 3.14, "Test 2 failed");

  // Test 3: Swap two characters
  char c1 = 'A';
  char c2 = 'B';
  change(c1, c2);
  assert(c1 == 'B' && c2 == 'A', "Test 3 failed");

  // Test 4: Swap two strings
  string s1 = "hello";
  string s2 = "world";
  change(s1, s2);
  assert(s1 == "world" && s2 == "hello", "Test 4 failed");

  // Test 5: Swap two boolean values
  bool flag1 = true;
  bool flag2 = false;
  change(flag1, flag2);
  assert(flag1 == false && flag2 == true, "Test 5 failed");

  // Test 6: Swap two identical values
  int same1 = 42;
  int same2 = 42;
  change(same1, same2);
  assert(same1 == 42 && same2 == 42, "Test 6 failed");

  // Test 7: Swap two structs
  struct Point {
    int x, y;
  }

  Point p1 = Point(1, 2);
  Point p2 = Point(3, 4);
  change(p1, p2);
  assert(p1.x == 3 && p1.y == 4 && p2.x == 1 && p2.y == 2, "Test 7 failed");
}

unittest {
  // Test 1: Swap two elements in the middle of the array
  int[] list = [1, 2, 3, 4];
  auto result = change(list, 1, 2);
  assert(result == [1, 3, 2, 4], "Test 1 failed");

  // Test 2: Swap two elements at the ends of the list
  list = [1, 2, 3, 4];
  result = change(list, 0, 3);
  assert(result == [4, 2, 3, 1], "Test 2 failed");

  // Test 3: No swap when positions are the same
  list = [1, 2, 3, 4];
  result = change(list, 2, 2);
  assert(result == [1, 2, 3, 4], "Test 3 failed");

  // Test 4: No swap when positions are out of bounds
  list = [1, 2, 3, 4];
  result = change(list, 1, 5);
  assert(result == [1, 2, 3, 4], "Test 4 failed");

  // Test 5: Swap elements in a string list
  string[] strList = ["a", "b", "c", "d"];
  auto strResult = change(strList, 1, 3);
  assert(strResult == ["a", "d", "c", "b"], "Test 5 failed");

  // Test 6: Swap elements in an list with duplicate values
  list = [1, 2, 2, 3];
  result = change(list, 1, 3);
  assert(result == [1, 3, 2, 2], "Test 6 failed");

  // Test 7: Empty list
  list = [];
  result = change(list, 0, 1);
  assert(result == [], "Test 7 failed");

  // Test 8: Single-element list
  list = [42];
  result = change(list, 0, 0);
  assert(result == [42], "Test 8 failed");
}
// #endregion change positions

// #region shiftLast
/**
 * Shifts the last elements of an array by a specified number of positions.
 *
 * This function modifies the input array in place by shifting its last
 * elements to the right by the given number of positions. Elements that are
 * shifted beyond the end of the array wrap around to the beginning.
 *
 * Params:
 *     values = The array to be shifted. This array is modified in place.
 *     times = The number of positions to shift the elements. If `times` is
 *             greater than the length of the array, it wraps around using
 *             modulo arithmetic.
 *
 * Returns:
 *     The modified array after the shift operation.
 */
T[] shiftLast(T)(ref T[] values, size_t times) {
  T[] results = [];

  if (values.length == 0) {
    return results;
  }

  if (times >= values.length) {
    results = values.dup;
    values = [];
    return results;
  }

  results = values[$ - times .. $];
  values = values[0 .. $ - times].dup;
  return results;
}

/**
 * Shifts the last element of an array and returns it.
 *
 * This function modifies the input array in place by removing the last
 * element and returning it. If the array is empty, it returns the default
 * value of type T.
 *
 * Params:
 *     values = The array to be shifted. This array is modified in place.
 *
 * Returns:
 *     The last element of the array before it was removed. If the array is
 *     empty, it returns the default value of type T.
 */
T shiftLast(T)(ref T[] values) {
  if (values.length == 0) {
    return T.init;
  }

  // values.length > 0
  T value = values[$ - 1];
  values = values.length == 1
    ? [] : values[0 .. $ - 1];

  return value;
}

unittest { // T shiftLast(T)(ref T[] values)
  // Test 1: Shift last element from a non-empty array
  int[] intArray = [1, 2, 3, 4];
  auto shiftedValue = shiftLast(intArray);
  assert(shiftedValue == 4, "Test 1 failed: Expected 4");
  assert(intArray == [1, 2, 3], "Test 1 failed: Expected [1, 2, 3]");

  // Test 2: Shift last element from a single-element array
  string[] strArray = ["hello"];
  auto shiftedStr = shiftLast(strArray);
  assert(shiftedStr == "hello", "Test 2 failed: Expected 'hello'");
  assert(strArray == null, "Test 2 failed: Expected null");

  // Test 3: Shift last element from an empty array
  double[] emptyArray;
  auto shiftedEmpty = shiftLast(emptyArray);
  // TODO: solve - assert(shiftedEmpty == double.init, "Test 3 failed: Expected init");
  assert(emptyArray == [], "Test 3 failed: Expected null");

  // Test 4: Shift last element from an array of structs
  struct Point {
    int x, y;
  }

  Point[] points = [Point(1, 2), Point(3, 4)];
  auto shiftedPoint = shiftLast(points);
  assert(shiftedPoint == Point(3, 4), "Test 4 failed: Expected Point(3, 4)");
  assert(points == [Point(1, 2)], "Test 4 failed: Expected [Point(1, 2)]");

  // Test 5: Shift last element from an array of booleans
  bool[] boolArray = [true, false, true];
  auto shiftedBool = shiftLast(boolArray);
  assert(shiftedBool == true, "Test 5 failed: Expected true");
  assert(boolArray == [true, false], "Test 5 failed: Expected [true, false]");
}

unittest { // T[] shiftLast(T)(ref T[] values, size_t times)
  // Test 1: Shift last multiple elements from a non-empty array
  int[] intArray = [1, 2, 3, 4, 5];
  auto shiftedValues = shiftLast(intArray, 3);
  assert(shiftedValues.equal([3, 4, 5]), "Test 1 failed: Expected [3, 4, 5]");
  assert(intArray.equal([1, 2]), "Test 1 failed: Expected [1, 2]");

  // Test 2: Shift last all elements from the array
  intArray = [10, 20, 30];
  shiftedValues = shiftLast(intArray, 3);
  assert(shiftedValues.equal([10, 20, 30]), "Test 2 failed: Expected [10, 20, 30]");
  assert(intArray.length == 0, "Test 2 failed: Expected null");

  // Test 3: Shift last more elements than the array contains
  intArray = [7, 8, 9];
  shiftedValues = shiftLast(intArray, 5);
  assert(shiftedValues.equal([7, 8, 9]), "Test 3 failed: Expected [7, 8, 9]");
  assert(intArray.length == 0, "Test 3 failed: Expected null");

  // Test 4: Shift last zero elements
  intArray = [1, 2, 3];
  shiftedValues = shiftLast(intArray, 0);
  assert(shiftedValues.length == 0, "Test 4 failed: Expected []");
  assert(intArray.equal([1, 2, 3]), "Test 4 failed: Expected [1, 2, 3]");

  // Test 5: Shift last from an empty array
  int[] emptyArray;
  shiftedValues = shiftLast(emptyArray, 2);
  assert(shiftedValues.length == 0, "Test 5 failed: Expected []");
  assert(emptyArray.length == 0, "Test 5 failed: Expected []");

  // Test 6: Shift last from an array of strings
  string[] strArray = ["a", "b", "c", "d"];
  auto shiftedStrValues = shiftLast(strArray, 2);
  assert(shiftedStrValues.equal(["c", "d"]), "Test 6 failed: Expected ['c', 'd']");
  assert(strArray.equal(["a", "b"]), "Test 6 failed: Expected ['a', 'b']");

  // Test 7: Shift last from an array of structs
  struct Point {
    int x, y;
  }

  Point[] points = [Point(1, 2), Point(3, 4), Point(5, 6)];
  auto shiftedPoints = shiftLast(points, 2);
  assert(shiftedPoints.equal([Point(3, 4), Point(5, 6)]), "Test 7 failed: Expected [Point(3, 4), Point(5, 6)]");
  assert(points.equal([Point(1, 2)]), "Test 7 failed: Expected [Point(1, 2)]");
}
// #endregion shiftLast

// #region unshift
T[] unshift(T)(ref T[] values, T[] newValues) {
  if (newValues is null) {
    return values;
  }
  if (values is null) {
    values = newValues.dup;
  } else {
    values = newValues ~ values;
  }
  return values;
}

T[] unshift(T)(ref T[] values, T newValue) {
  if (values is null) {
    values = [newValue];
  } else {
    values = newValue ~ values;
  }
  return values;
}

unittest { // T[] unshift(T)(ref T[] values, T newValue)
  // Test 1: Unshift into a non-empty array
  int[] values = [2, 3, 4];
  auto result = unshift(values, 1);
  assert(result.equal([1, 2, 3, 4]), "Test 1 failed: Expected [1, 2, 3, 4]");
  assert(values.equal([1, 2, 3, 4]), "Test 1 failed: Expected [1, 2, 3, 4]");

  // Test 2: Unshift into an empty array
  int[] emptyValues;
  result = unshift(emptyValues, 42);
  assert(result.equal([42]), "Test 2 failed: Expected [42]");
  assert(emptyValues.equal([42]), "Test 2 failed: Expected [42]");

  // Test 3: Unshift into a null array
  int[] nullValues = null;
  result = unshift(nullValues, 99);
  assert(result.equal([99]), "Test 3 failed: Expected [99]");
  assert(nullValues.equal([99]), "Test 3 failed: Expected [99]");

  // Test 4: Unshift a string into a string array
  string[] strValues = ["b", "c"];
  auto strResult = unshift(strValues, "a");
  assert(strResult.equal(["a", "b", "c"]), "Test 4 failed: Expected ['a', 'b', 'c']");
  assert(strValues.equal(["a", "b", "c"]), "Test 4 failed: Expected ['a', 'b', 'c']");

  // Test 5: Unshift into an array of structs
  struct Point {
    int x, y;
  }

  Point[] points = [Point(2, 3), Point(4, 5)];
  auto pointResult = unshift(points, Point(1, 2));
  assert(pointResult.equal([Point(1, 2), Point(2, 3), Point(4, 5)]), "Test 5 failed: Expected [Point(1, 2), Point(2, 3), Point(4, 5)]");
  assert(points.equal([Point(1, 2), Point(2, 3), Point(4, 5)]), "Test 5 failed: Expected [Point(1, 2), Point(2, 3), Point(4, 5)]");

  // Test 6: Unshift a boolean value
  bool[] boolValues = [false, true];
  auto boolResult = unshift(boolValues, true);
  assert(boolResult.equal([true, false, true]), "Test 6 failed: Expected [true, false, true]");
  assert(boolValues.equal([true, false, true]), "Test 6 failed: Expected [true, false, true]");
}

unittest { // T[] unshift(T)(ref T[] values, T[] newValues)
  // Test 1: Unshift multiple elements into a non-empty array
  int[] values = [3, 4, 5];
  auto result = unshift(values, [1, 2]);
  assert(result.equal([1, 2, 3, 4, 5]), "Test 1 failed: Expected [1, 2, 3, 4, 5]");
  assert(values.equal([1, 2, 3, 4, 5]), "Test 1 failed: Expected [1, 2, 3, 4, 5]");

  // Test 2: Unshift multiple elements into an empty array
  int[] emptyValues;
  result = unshift(emptyValues, [10, 20]);
  assert(result.equal([10, 20]), "Test 2 failed: Expected [10, 20]");
  assert(emptyValues.equal([10, 20]), "Test 2 failed: Expected [10, 20]");

  // Test 3: Unshift multiple elements into a null array
  int[] nullValues = null;
  result = unshift(nullValues, [7, 8, 9]);
  assert(result.equal([7, 8, 9]), "Test 3 failed: Expected [7, 8, 9]");
  assert(nullValues.equal([7, 8, 9]), "Test 3 failed: Expected [7, 8, 9]");

  // Test 4: Unshift null into a non-empty array
  int[] nonEmptyValues = [4, 5, 6];
  result = unshift(nonEmptyValues, null);
  assert(result.equal([4, 5, 6]), "Test 4 failed: Expected [4, 5, 6]");
  assert(nonEmptyValues.equal([4, 5, 6]), "Test 4 failed: Expected [4, 5, 6]");

  // Test 5: Unshift multiple strings into a string array
  string[] strValues = ["c", "d"];
  auto strResult = unshift(strValues, ["a", "b"]);
  assert(strResult.equal(["a", "b", "c", "d"]), "Test 5 failed: Expected ['a', 'b', 'c', 'd']");
  assert(strValues.equal(["a", "b", "c", "d"]), "Test 5 failed: Expected ['a', 'b', 'c', 'd']");

  // Test 6: Unshift multiple elements into an array of structs
  struct Point {
    int x, y;
  }

  Point[] points = [Point(3, 4), Point(5, 6)];
  auto pointResult = unshift(points, [Point(1, 2)]);
  assert(pointResult.equal([Point(1, 2), Point(3, 4), Point(5, 6)]), "Test 6 failed: Expected [Point(1, 2), Point(3, 4), Point(5, 6)]");
  assert(points.equal([Point(1, 2), Point(3, 4), Point(5, 6)]), "Test 6 failed: Expected [Point(1, 2), Point(3, 4), Point(5, 6)]");

  // Test 7: Unshift multiple boolean values
  bool[] boolValues = [false, true];
  auto boolResult = unshift(boolValues, [true, false]);
  assert(boolResult.equal([true, false, false, true]), "Test 7 failed: Expected [true, false, false, true]");
  assert(boolValues.equal([true, false, false, true]), "Test 7 failed: Expected [true, false, false, true]");
}
// #endregion unshift

// #region unshift
/**
 * Unshifts the last elements of an array by a specified number of positions.
 *
 * This function modifies the input array in place by unshifting its last
 * elements to the left by the given number of positions. Elements that are
 * unshifted beyond the beginning of the array are removed.
 *
 * Params:
 *     values = The array to be unshifted. This array is modified in place.
 *     times = The number of positions to unshift the elements. If `times` is
 *             greater than the length of the array, it wraps around using
 *             modulo arithmetic.
 *
 * Returns:
 *     The modified array after the unshift operation.
 */
T[] unshiftLast(T)(ref T[] values, T[] newValues) {
  if (newValues is null) {
    return values;
  }
  if (values is null) {
    values = newValues.dup;
  } else {
    values = values ~ newValues;
  }
  return values;
}

/**
 * Unshifts a single element into the last position of an array.
 *
 * This function modifies the input array in place by unshifting a new value
 * to the last position. If the array is null, it initializes it with the new
 * value.
 *
 * Params:
 *     values = The array to be unshifted. This array is modified in place.
 *     newValue = The new value to be added to the last position of the array.
 *
 * Returns:
 *     The modified array after the unshift operation.
 */
T[] unshiftLast(T)(ref T[] values, T newValue) {
  if (values is null) {
    values = [newValue];
  } else {
    values = values ~ [newValue];
  }
  return values;
}

unittest { // T[] unshiftLast(T)(ref T[] values, T newValue)
  // Test 1: UnshiftLast into a non-empty array
  int[] values = [2, 3, 4];
  auto result = unshiftLast(values, 5);
  assert(result.equal([2, 3, 4, 5]), "Test 1 failed: Expected [2, 3, 4, 5]");
  assert(values.equal([2, 3, 4, 5]), "Test 1 failed: Expected [2, 3, 4, 5]");

  // Test 2: UnshiftLast into an empty array
  int[] emptyValues;
  result = unshiftLast(emptyValues, 42);
  assert(result.equal([42]), "Test 2 failed: Expected [42]");
  assert(emptyValues.equal([42]), "Test 2 failed: Expected [42]");

  // Test 3: UnshiftLast into a null array
  int[] nullValues = null;
  result = unshiftLast(nullValues, 99);
  assert(result.equal([99]), "Test 3 failed: Expected [99]");
  assert(nullValues.equal([99]), "Test 3 failed: Expected [99]");

  // Test 4: UnshiftLast a string into a string array
  string[] strValues = ["a", "b"];
  auto strResult = unshiftLast(strValues, "c");
  assert(strResult.equal(["a", "b", "c"]), "Test 4 failed: Expected ['a', 'b', 'c']");
  assert(strValues.equal(["a", "b", "c"]), "Test 4 failed: Expected ['a', 'b', 'c']");

  // Test 5: UnshiftLast into an array of structs
  struct Point {
    int x, y;
  }

  Point[] points = [Point(1, 2), Point(3, 4)];
  auto pointResult = unshiftLast(points, Point(5, 6));
  assert(pointResult.equal([Point(1, 2), Point(3, 4), Point(5, 6)]), "Test 5 failed: Expected [Point(1, 2), Point(3, 4), Point(5, 6)]");
  assert(points.equal([Point(1, 2), Point(3, 4), Point(5, 6)]), "Test 5 failed: Expected [Point(1, 2), Point(3, 4), Point(5, 6)]");

  // Test 6: UnshiftLast a boolean value
  bool[] boolValues = [true, false];
  auto boolResult = unshiftLast(boolValues, true);
  assert(boolResult.equal([true, false, true]), "Test 6 failed: Expected [true, false, true]");
  assert(boolValues.equal([true, false, true]), "Test 6 failed: Expected [true, false, true]");
}

unittest { // T[] unshiftLast(T)(ref T[] values, T[] newValues)
  // Test 1: UnshiftLast multiple elements into a non-empty array
  int[] values = [2, 3, 4];
  auto result = unshiftLast(values, [5, 6]);
  assert(result.equal([2, 3, 4, 5, 6]), "Test 1 failed: Expected [2, 3, 4, 5, 6]");
  assert(values.equal([2, 3, 4, 5, 6]), "Test 1 failed: Expected [2, 3, 4, 5, 6]");

  // Test 2: UnshiftLast multiple elements into an empty array
  int[] emptyValues;
  result = unshiftLast(emptyValues, [42, 43]);
  assert(result.equal([42, 43]), "Test 2 failed: Expected [42, 43]");
  assert(emptyValues.equal([42, 43]), "Test 2 failed: Expected [42, 43]");

  // Test 3: UnshiftLast multiple elements into a null array
  int[] nullValues = null;
  result = unshiftLast(nullValues, [99, 100]);
  assert(result.equal([99, 100]), "Test 3 failed: Expected [99, 100]");
  assert(nullValues.equal([99, 100]), "Test 3 failed: Expected [99, 100]");

  // Test 4: UnshiftLast null into a non-empty array
  int[] nonEmptyValues = [4, 5, 6];
  result = unshiftLast(nonEmptyValues, null);
  assert(result.equal([4, 5, 6]), "Test 4 failed: Expected [4, 5, 6]");
  assert(nonEmptyValues.equal([4, 5, 6]), "Test 4 failed: Expected [4, 5, 6]");

  // Test 5: UnshiftLast multiple strings into a string array
  string[] strValues = ["a", "b"];
  auto strResult = unshiftLast(strValues, ["c", "d"]);
  assert(strResult.equal(["a", "b", "c", "d"]), "Test 5 failed: Expected ['a', 'b', 'c', 'd']");
  assert(strValues.equal(["a", "b", "c", "d"]), "Test 5 failed: Expected ['a', 'b', 'c', 'd']");

  // Test 6: UnshiftLast multiple elements into an array of structs
  struct Point {
    int x, y;
  }

  Point[] points = [Point(1, 2), Point(3, 4)];
  auto pointResult = unshiftLast(points, [Point(5, 6), Point(7, 8)]);
  assert(pointResult.equal([Point(1, 2), Point(3, 4), Point(5, 6), Point(7, 8)]), "Test 6 failed: Expected [Point(1, 2), Point(3, 4), Point(5, 6), Point(7, 8)]");
  assert(points.equal([Point(1, 2), Point(3, 4), Point(5, 6), Point(7, 8)]), "Test 6 failed: Expected [Point(1, 2), Point(3, 4), Point(5, 6), Point(7, 8)]");

  // Test 7: UnshiftLast multiple boolean values
  bool[] boolValues = [true, false];
  auto boolResult = unshiftLast(boolValues, [false, true]);
  assert(boolResult.equal([true, false, false, true]), "Test 7 failed: Expected [true, false, false, true]");
  assert(boolValues.equal([true, false, false, true]), "Test 7 failed: Expected [true, false, false, true]");
}
// #region unshiftLast

// #region slice
/**
 * Slices an array into a new array based on the specified start and end indices.
 *
 * This function creates a new array that contains the elements from the original
 * array starting from the specified start index up to (but not including) the
 * specified end index. If the start index is greater than or equal to the length
 * of the array, an empty array is returned. If the end index is greater than
 * the length of the array, it is adjusted to be equal to the length of the array.
 *
 * Params:
 *     values = The original array to be sliced.
 *     start = The starting index for slicing (inclusive).
 *     end = The ending index for slicing (exclusive).
 *
 * Returns:
 *     A new array containing the sliced elements.
 */
T[] slice(T)(T[] values, size_t start, size_t end) {
  if (start >= values.length) {
    return [];
  }
  if (start > end) {
    return [];
  }

  if (end > values.length) {
    end = values.length;
  }
  return values[start .. end];
}

unittest { // T[] slice(T)(T[] values, size_t start, size_t end)
  // Test 1: Slice within bounds
  int[] values = [1, 2, 3, 4, 5];
  auto result = slice(values, 1, 4);
  assert(result.equal([2, 3, 4]), "Test 1 failed: Expected [2, 3, 4]");

  // Test 2: Slice with start index equal to array length
  result = slice(values, 5, 7);
  assert(result.length == 0, "Test 2 failed: Expected []");

  // Test 3: Slice with end index greater than array length
  result = slice(values, 3, 10);
  assert(result.equal([4, 5]), "Test 3 failed: Expected [4, 5]");

  // Test 4: Slice with start index greater than end index
  result = slice(values, 4, 2);
  assert(result.length == 0, "Test 4 failed: Expected []");

  // Test 5: Slice with start index out of bounds
  result = slice(values, 10, 12);
  assert(result.length == 0, "Test 5 failed: Expected []");

  // Test 6: Slice the entire array
  result = slice(values, 0, values.length);
  assert(result.equal([1, 2, 3, 4, 5]), "Test 6 failed: Expected [1, 2, 3, 4, 5]");

  // Test 7: Slice an empty array
  int[] emptyValues;
  result = slice(emptyValues, 0, 2);
  assert(result.length == 0, "Test 7 failed: Expected []");

  // Test 8: Slice with negative indices (not applicable in D, but ensure no crash)
  result = slice(values, cast(size_t)-1, cast(size_t)-3);
  assert(result.length == 0, "Test 8 failed: Expected []");
}
// #endregion slice

// #region concatPrefix
V[string] concatPrefix(V)(V[string] map, string[string] prefixMap) {
  prefixMap.byKeyValue.each!(kv => map.concatPrefix(kv.key, kv.value));
  return map;
}

V[string] concatPrefix(V)(V[string] map, string prefix) {
  return map.concatPrefix(map.keys, prefix);
}

V[string] concatPrefix(V)(V[string] map, string[] keys, string prefix) {
  keys.each!(key => map.concatPrefix(key, prefix));
  return map;
}

V[string] concatPrefix(V)(V[string] map, string key, string prefix) {
  if (key !in map) {
    return map;
  }

  V value = map[key];
  map.remove(key);
  map[prefix ~ key] = value;

  return map;
}

unittest {
  auto test = ["a": "b", "c": "d", "e": "f"];
  test.concatPrefix("a", "xx");
  assert("xxa" in test);

  test = ["a": "b", "c": "d", "e": "f"];
  test.concatPrefix(["a", "c"], "xx");
  assert("xxa" in test && "xxc" in test && "e" in test);

  test = ["a": "b", "c": "d", "e": "f"];
  test.concatPrefix(["a": "xx", "c": "yy"]);
  assert("xxa" in test && "yyc" in test && "e" in test);

  test = ["a": "b", "c": "d", "e": "f"];
  test.concatPrefix("xx");
  assert("xxa" in test && "xxc" in test && "xxe" in test);
}
// #endregion concatPrefix

// #region concatPostfix
V[string] concatPostfix(V)(V[string] map, string[string] postfixMap) {
  postfixMap.byKeyValue.each!(kv => map.concatPostfix(kv.key, kv.value));
  return map;
}

V[string] concatPostfix(V)(V[string] map, string postfix) {
  return map.concatPostfix(map.keys, postfix);
}

V[string] concatPostfix(V)(V[string] map, string[] keys, string postfix) {
  keys.each!(key => map.concatPostfix(key, postfix));
  return map;
}

V[string] concatPostfix(V)(V[string] map, string key, string postfix) {
  if (key !in map) {
    return map;
  }

  V value = map[key];
  map.remove(key);
  map[key ~ postfix] = value;

  return map;
}

unittest {
  auto test = ["a": "b", "c": "d", "e": "f"];
  test.concatPostfix("a", "xx");
  assert("axx" in test);

  test = ["a": "b", "c": "d", "e": "f"];
  test.concatPostfix(["a", "c"], "xx");
  assert("axx" in test && "cxx" in test && "e" in test);

  test = ["a": "b", "c": "d", "e": "f"];
  test.concatPostfix(["a": "xx", "c": "yy"]);
  assert("axx" in test && "cyy" in test && "e" in test);

  test = ["a": "b", "c": "d", "e": "f"];
  test.concatPostfix("xx");
  assert("axx" in test && "cxx" in test && "exx" in test);
}
// #endregion concatPostfix

// #region rotate
/**
 * Rotates an element in an array to the next or previous position.
 *
 * This function rotates the specified value in the array to the next or
 * previous position based on the direction specified. If the value is not
 * found in the array, it returns the original value.
 *
 * Params:
 *     value = The value to be rotated.
 *     values = The array containing the values.
 *     directionRight = If true, rotates to the right; otherwise, rotates to the left.
 *
 * Returns:
 *     The rotated value.
 */
T rotate(T)(T value, T[] values, bool directionRight = true) {
  if (values.length == 0) {
    return value;
  }

  foreach (index, val; values) {
    if (val == value) {
      return directionRight
        ? rotateRight(value, values)
        : rotateLeft(value,values);
    }
  }
  return value;
}

T rotateLeft(T)(T value, T[] values) {
  if (values.length == 0) {
    return value;
  }

  foreach (index, val; values) {
    if (val == value) { // Found value
      return index == 0 // Index on first element
      ? values[$ - 1] // Wrap around to last element
         : values[index - 1]; // Move to previous element
    }
  }
  return value;
}

T rotateRight(T)(T value, T[] values) {
  if (values.length == 0) {
    return value;
  }

  foreach (index, val; values) {
    if (val == value) { // Found value
      return index == values.length - 1 // Index on last element
      ? values[0] // Wrap around to first element
         : values[index + 1]; // Move to next element
    }
  }
  return value;
}

unittest { // T rotateRight(T)(T value, T[] values)
    // Test 1: Rotate right in a non-empty array
    int[] values = [1, 2, 3, 4, 5];
    auto result = rotateRight(3, values);
    assert(result == 4, "Test 1 failed: Expected 4");

    // Test 2: Rotate right on the last element
    result = rotateRight(5, values);
    assert(result == 1, "Test 2 failed: Expected 1");

    // Test 3: Rotate right on the first element
    result = rotateRight(1, values);
    assert(result == 2, "Test 3 failed: Expected 2");

    // Test 4: Rotate right on an element not in the array
    result = rotateRight(6, values);
    assert(result == 6, "Test 4 failed: Expected 6");

    // Test 5: Rotate right on an empty array
    int[] emptyValues;
    result = rotateRight(1, emptyValues);
    assert(result == 1, "Test 5 failed: Expected 1");

    // Test 6: Rotate right on a single-element array
    int[] singleValue = [42];
    result = rotateRight(42, singleValue);
    assert(result == 42, "Test 6 failed: Expected 42");

    // Test 7: Rotate right on a string array
    string[] strValues = ["a", "b", "c"];
    auto strResult = rotateRight("b", strValues);
    assert(strResult == "c", "Test 7 failed: Expected 'c'");

    // Test 8: Rotate right on the last string element
    strResult = rotateRight("c", strValues);
    assert(strResult == "a", "Test 8 failed: Expected 'a'");

    // Test 9: Rotate right on an element not in the string array
    strResult = rotateRight("z", strValues);
    assert(strResult == "z", "Test 9 failed: Expected 'z'");
}

unittest { // T rotateLeft(T)(T value, T[] values)
    // Test 1: Rotate left in a non-empty array
    int[] values = [1, 2, 3, 4, 5];
    auto result = rotateLeft(3, values);
    assert(result == 2, "Test 1 failed: Expected 2");

    // Test 2: Rotate left on the first element
    result = rotateLeft(1, values);
    assert(result == 5, "Test 2 failed: Expected 5");

    // Test 3: Rotate left on the last element
    result = rotateLeft(5, values);
    assert(result == 4, "Test 3 failed: Expected 4");

    // Test 4: Rotate left on an element not in the array
    result = rotateLeft(6, values);
    assert(result == 6, "Test 4 failed: Expected 6");

    // Test 5: Rotate left on an empty array
    int[] emptyValues;
    result = rotateLeft(1, emptyValues);
    assert(result == 1, "Test 5 failed: Expected 1");

    // Test 6: Rotate left on a single-element array
    int[] singleValue = [42];
    result = rotateLeft(42, singleValue);
    assert(result == 42, "Test 6 failed: Expected 42");

    // Test 7: Rotate left on a string array
    string[] strValues = ["a", "b", "c"];
    auto strResult = rotateLeft("b", strValues);
    assert(strResult == "a", "Test 7 failed: Expected 'a'");

    // Test 8: Rotate left on the first string element
    strResult = rotateLeft("a", strValues);
    assert(strResult == "c", "Test 8 failed: Expected 'c'");

    // Test 9: Rotate left on an element not in the string array
    strResult = rotateLeft("z", strValues);
    assert(strResult == "z", "Test 9 failed: Expected 'z'");
}
// #endregion rotate

// #region toogle
bool toggle(bool value) {
  return !value;
}

T toggle(T)(T value, T firstValue, T secondValue) {
  if (value == firstValue) {
    return secondValue;
  }
  if (value == secondValue) {
    return firstValue;
  }
  return value;
}

unittest { // T toggle(T)(T value, T firstValue, T secondValue) 
    // Test 1: Toggle between two integers
    assert(toggle(1, 1, 2) == 2, "Test 1 failed: Expected 2");
    assert(toggle(2, 1, 2) == 1, "Test 1 failed: Expected 1");
    assert(toggle(3, 1, 2) == 3, "Test 1 failed: Expected 3");

    // Test 2: Toggle between two strings
    assert(toggle("Yes", "Yes", "No") == "No", "Test 2 failed: Expected 'No'");
    assert(toggle("No", "Yes", "No") == "Yes", "Test 2 failed: Expected 'Yes'");
    assert(toggle("Maybe", "Yes", "No") == "Maybe", "Test 2 failed: Expected 'Maybe'");

    // Test 3: Toggle between two characters
    assert(toggle('a', 'a', 'b') == 'b', "Test 3 failed: Expected 'b'");
    assert(toggle('b', 'a', 'b') == 'a', "Test 3 failed: Expected 'a'");
    assert(toggle('c', 'a', 'b') == 'c', "Test 3 failed: Expected 'c'");

    // Test 4: Toggle between two booleans
    assert(toggle(true, true, false) == false, "Test 4 failed: Expected false");
    assert(toggle(false, true, false) == true, "Test 4 failed: Expected true");

    // Test 5: Toggle with identical first and second values
    assert(toggle(1, 1, 1) == 1, "Test 5 failed: Expected 1");

    // Test 6: Toggle with null values
    string nullValue = null;
    assert(toggle(nullValue, null, "NonNull") == "NonNull", "Test 6 failed: Expected 'NonNull'");
    assert(toggle("NonNull", null, "NonNull") == null, "Test 6 failed: Expected null");

    // Test 7: Toggle with floating-point numbers
    assert(toggle(1.5, 1.5, 2.5) == 2.5, "Test 7 failed: Expected 2.5");
    assert(toggle(2.5, 1.5, 2.5) == 1.5, "Test 7 failed: Expected 1.5");
    assert(toggle(3.5, 1.5, 2.5) == 3.5, "Test 7 failed: Expected 3.5");
}

unittest { // bool toggle(bool value)
    // Test 1: Toggle a true value
    bool value = true;
    auto result = toggle(value);
    assert(result == false, "Test 1 failed: Expected false");

    // Test 2: Toggle a false value
    value = false;
    result = toggle(value);
    assert(result == true, "Test 2 failed: Expected true");

    // Test 3: Toggle multiple times
    value = true;
    result = toggle(toggle(value));
    assert(result == value, "Test 3 failed: Expected the original value after two toggles");
}
// #endregion toogle