/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.algorithms.comparisons;

import uim.phobos;
@safe:

// #region isAllEqual
// all values in array are equal to value
bool isAllEqual(T)(T[] values, T compare) {
  return values
    .filter!(value => value != compare).array.length == 0;
}

unittest {
  assert([1, 1, 1].isAllEqual(1));
  assert(![1, 2, 1].isAllEqual(1));
}
// #endregion isAllEqual

// #region isAnyEqual
bool isAnyEqual(T)(T[] values, T compare) {
  return (values.filter!(value => value == compare).array.length > 0);
}
///
unittest {
  assert([1, 1, 1].isAnyEqual(1));
  assert(![1, 2, 1].isAnyEqual(3));
  assert([1, 2, 1].isAnyEqual(1));
}
// #endregion isAnyEqual

// #region isGreater
// all values in array are greater to value
bool isAllGreater(T)(T[] values, T compare) {
  return values.all!(value => value.isGreater(compare));
}

bool isAnyGreater(T)(T[] values, T compare) {
  return values.any!(value => value.isGreater(compare));
}

bool isGreater(T)(T value, T compare) {
  return (value > compare);
}

unittest { // isGreater(T)(T base, T value)
  // Test with integers
  assert(isGreater(5, 3) == true, "5 > 3 should be true");
  assert(isGreater(3, 5) == false, "3 > 5 should be false");
  assert(isGreater(5, 5) == false, "5 > 5 should be false");

  // Test with floating point numbers
  assert(isGreater(2.5, 1.5) == true, "2.5 > 1.5 should be true");
  assert(isGreater(1.5, 2.5) == false, "1.5 > 2.5 should be false");
  assert(isGreater(2.5, 2.5) == false, "2.5 > 2.5 should be false");

  // Test with characters
  assert(isGreater('b', 'a') == true, "'b' > 'a' should be true");
  assert(isGreater('a', 'b') == false, "'a' > 'b' should be false");
  assert(isGreater('a', 'a') == false, "'a' > 'a' should be false");
}

unittest { // bool isAnyGreater(T)(T[] values, T compare)
  // Test with integers
  assert(isAnyGreater([2, 3, 4], 1) == true, "[2, 3, 4] > 1 should be true, but current impl checks equality");
  assert(isAnyGreater([1, 2, 3], 2) == true, "[1, 2, 3] contains 2, so returns true (current impl checks equality)");
  assert(isAnyGreater([1, 2, 3], 4) == false, "[1, 2, 3] does not contain 4, so returns false");

  // Test with floating point numbers
  assert(isAnyGreater([1.5, 2.5, 3.5], 2.5) == true, "[1.5, 2.5, 3.5] contains 2.5");
  assert(isAnyGreater([1.5, 2.5, 3.5], 4.5) == false, "[1.5, 2.5, 3.5] does not contain 4.5");

  // Test with characters
  assert(isAnyGreater(['a', 'b', 'c'], 'b') == true, "['a', 'b', 'c'] contains 'b'");
  assert(isAnyGreater(['a', 'b', 'c'], 'd') == false, "['a', 'b', 'c'] does not contain 'd'");

  // Test with empty array
  assert(isAnyGreater!int([], 1) == false, "Empty array should return false");
}

unittest { // bool isAllGreater(T)(T[] values, T compare)
  // Test with integers
  assert(isAllGreater([5, 6, 7], 4) == true, "[5, 6, 7] > 4 should be true");
  assert(isAllGreater([2, 2, 2], 2) == false, "[2, 2, 2] not > 2, so returns false");
  assert(isAllGreater([1, 2, 3], 2) == false, "[1, 2, 3] not all > 2 for one element, so returns false");
  assert(isAllGreater([3, 3, 3], 4) == false, "[3, 3, 3] != 4, so returns false");

  // Test with floating point numbers
  assert(isAllGreater([2.5, 2.5, 2.5], 2.5) == false, "[2.5, 2.5, 2.5] == 2.5, so returns false");
  assert(isAllGreater([1.5, 2.5, 3.5], 2.5) == false, "[1.5, 2.5, 3.5] > 2.5 for one element, so returns false");
  assert(isAllGreater([4.5, 4.5, 4.5], 3.5) == true, "[4.5, 4.5, 4.5] > 3.5, so returns false");

  // Test with characters
  assert(isAllGreater(['b', 'b', 'b'], 'b') == false, "['b', 'b', 'b'] not > 'b', so returns true");
  assert(isAllGreater(['a', 'b', 'c'], 'b') == false, "['a', 'b', 'c'] == 'b' for one element, so returns false");
  assert(isAllGreater(['c', 'c', 'c'], 'd') == false, "['c', 'c', 'c'] != 'd', so returns false");

  // Test with empty array
  assert(isAllGreater!int([], 1) == true, "Empty array should return true (vacuously true)");
}
// #endregion isGreater

// #region isGreaterEqual
// all values in array are greater to value
bool isAllGreaterEqual(T)(T[] values, T compare) {
  return values.all!(value => value.isGreaterEqual(compare));
}

bool isAnyGreaterEqual(T)(T[] values, T compare) {
  return values.any!(value => value.isGreaterEqual(compare));
}

bool isGreaterEqual(T)(T value, T compare) {
  return (value >= compare);
}

unittest {
  // Test isGreaterEqual with integers
  assert(isGreaterEqual(5, 3) == true, "5 >= 3 should be true");
  assert(isGreaterEqual(3, 5) == false, "3 >= 5 should be false");
  assert(isGreaterEqual(5, 5) == true, "5 >= 5 should be true");

  // Test isGreaterEqual with floating point numbers
  assert(isGreaterEqual(2.5, 1.5) == true, "2.5 >= 1.5 should be true");
  assert(isGreaterEqual(1.5, 2.5) == false, "1.5 >= 2.5 should be false");
  assert(isGreaterEqual(2.5, 2.5) == true, "2.5 >= 2.5 should be true");

  // Test isGreaterEqual with characters
  assert(isGreaterEqual('b', 'a') == true, "'b' >= 'a' should be true");
  assert(isGreaterEqual('a', 'b') == false, "'a' >= 'b' should be false");
  assert(isGreaterEqual('a', 'a') == true, "'a' >= 'a' should be true");
}

unittest {
  // Test isAnyGreaterEqual with integers
  assert(isAnyGreaterEqual([1, 2, 3], 2) == true, "[1, 2, 3] has elements >= 2");
  assert(isAnyGreaterEqual([1, 2, 3], 4) == false, "[1, 2, 3] has no elements >= 4");
  assert(isAnyGreaterEqual([2, 2, 2], 2) == true, "[2, 2, 2] all elements >= 2");

  // Test isAnyGreaterEqual with floating point numbers
  assert(isAnyGreaterEqual([1.5, 2.5, 3.5], 2.5) == true, "[1.5, 2.5, 3.5] has elements >= 2.5");
  assert(isAnyGreaterEqual([1.5, 2.5, 3.5], 4.0) == false, "[1.5, 2.5, 3.5] has no elements >= 4.0");
  assert(isAnyGreaterEqual([2.5, 2.5, 2.5], 2.5) == true, "[2.5, 2.5, 2.5] all elements >= 2.5");

  // Test isAnyGreaterEqual with characters
  assert(isAnyGreaterEqual(['a', 'b', 'c'], 'b') == true, "['a', 'b', 'c'] has elements >= 'b'");
  assert(isAnyGreaterEqual(['a', 'b', 'c'], 'd') == false, "['a', 'b', 'c'] has no elements >= 'd'");
  assert(isAnyGreaterEqual(['b', 'b', 'b'], 'b') == true, "['b', 'b', 'b'] all elements >= 'b'");

  // Test with empty array
  assert(isAnyGreaterEqual!int([], 1) == false, "Empty array should return false");
}

unittest {
  // Test isAllGreaterEqual with integers
  assert(isAllGreaterEqual([1, 2, 3], 1) == true, "[1, 2, 3] all elements >= 1");
  assert(isAllGreaterEqual([1, 2, 3], 2) == false, "[1, 2, 3] includes 1, which is not >= 2");
  assert(isAllGreaterEqual([2, 2, 2], 2) == true, "[2, 2, 2] all elements >= 2");

  // Test isAllGreaterEqual with floating point numbers
  assert(isAllGreaterEqual([1.1, 2.2, 3.3], 1.1) == true, "[1.1, 2.2, 3.3] all elements >= 1.1");
  assert(isAllGreaterEqual([1.1, 2.2, 3.3], 2.2) == false, "[1.1, 2.2, 3.3] includes 1.1, which is not >= 2.2");
  assert(isAllGreaterEqual([2.5, 2.5, 2.5], 2.5) == true, "[2.5, 2.5, 2.5] all elements >= 2.5");

  // Test isAllGreaterEqual with characters
  assert(isAllGreaterEqual(['a', 'b', 'c'], 'a') == true, "['a', 'b', 'c'] all elements >= 'a'");
  assert(isAllGreaterEqual(['a', 'b', 'c'], 'b') == false, "['a', 'b', 'c'] includes 'a', which is not >= 'b'");
  assert(isAllGreaterEqual(['b', 'b', 'b'], 'b') == true, "['b', 'b', 'b'] all elements >= 'b'");

  // Test with empty array (should be vacuously true)
  assert(isAllGreaterEqual!int([], 10) == true, "Empty array should return true (vacuously true)");
}
// #endregion isGreaterEqual

// #region isLess
// all values in array are less to value
bool isAllLess(T)(T[] values, T compare) {
  return values.all!(value => value.isLess(compare));
}

bool isAnyLess(T)(T[] values, T compare) {
  return values.any!(value => value.isLess(compare));
}

bool isLess(T)(T value, T compare) {
  return (value < compare);
}

unittest { // isLess(T)(T base, T value)
  // Test with integers
  assert(isLess(3, 5) == true, "3 < 5 should be true");
  assert(isLess(5, 3) == false, "5 < 3 should be false");
  assert(isLess(5, 5) == false, "5 < 5 should be false");

  // Test with floating point numbers
  assert(isLess(1.5, 2.5) == true, "1.5 < 2.5 should be true");
  assert(isLess(2.5, 1.5) == false, "2.5 < 1.5 should be false");
  assert(isLess(2.5, 2.5) == false, "2.5 < 2.5 should be false");

  // Test with characters
  assert(isLess('a', 'b') == true, "'a' < 'b' should be true");
  assert(isLess('b', 'a') == false, "'b' < 'a' should be false");
  assert(isLess('a', 'a') == false, "'a' < 'a' should be false");
}

unittest { // bool isAnyLess(T)(T[] values, T compare)
  // Test with integers
  assert(isAnyLess([1, 2, 3], 2) == true, "[1, 2, 3] has elements less than 2");
  assert(isAnyLess([2, 3, 4], 1) == false, "[2, 3, 4] has no elements less than 1");
  assert(isAnyLess([2, 2, 2], 2) == false, "[2, 2, 2] has no elements less than 2");

  // Test with floating point numbers
  assert(isAnyLess([1.5, 2.5, 3.5], 2.5) == true, "[1.5, 2.5, 3.5] has elements less than 2.5");
  assert(isAnyLess([2.5, 3.5, 4.5], 2.0) == false, "[2.5, 3.5, 4.5] has no elements less than 2.0");
  assert(isAnyLess([2.5, 2.5, 2.5], 2.5) == false, "[2.5, 2.5, 2.5] has no elements less than 2.5");

  // Test with characters
  assert(isAnyLess(['a', 'b', 'c'], 'b') == true, "['a', 'b', 'c'] has elements less than 'b'");
  assert(isAnyLess(['b', 'c', 'd'], 'a') == false, "['b', 'c', 'd'] has no elements less than 'a'");
  assert(isAnyLess(['b', 'b', 'b'], 'b') == false, "['b', 'b', 'b'] has no elements less than 'b'");

  // Test with empty array
  assert(isAnyLess!int([], 1) == false, "Empty array should return false");
}

unittest { // bool isAllLess(T)(T[] values, T compare)
  // Test with integers
  assert(isAllLess([1, 2, 3], 4) == true, "[1, 2, 3] are all less than 4");
  assert(isAllLess([1, 2, 3], 3) == false, "[1, 2, 3] includes 3, which is not less than 3");
  assert(isAllLess([4, 5, 6], 4) == false, "[4, 5, 6] includes values not less than 4");
  assert(isAllLess([0, -1, -2], 1) == true, "[0, -1, -2] are all less than 1");
  assert(isAllLess([1, 1, 1], 2) == true, "[1, 1, 1] are all less than 2");

  // Test with floating point numbers
  assert(isAllLess([1.1, 2.2, 3.3], 4.4) == true, "[1.1, 2.2, 3.3] are all less than 4.4");
  assert(isAllLess([1.1, 2.2, 3.3], 3.3) == false, "[1.1, 2.2, 3.3] includes 3.3, which is not less than 3.3");
  assert(isAllLess([4.4, 5.5, 6.6], 4.4) == false, "[4.4, 5.5, 6.6] includes values not less than 4.4");
  assert(isAllLess([-1.0, -2.0, -3.0], 0.0) == true, "All negative values are less than 0.0");

  // Test with characters
  assert(isAllLess(['a', 'b', 'c'], 'd') == true, "['a', 'b', 'c'] are all less than 'd'");
  assert(isAllLess(['a', 'b', 'c'], 'c') == false, "['a', 'b', 'c'] includes 'c', which is not less than 'c'");
  assert(isAllLess(['x', 'y', 'z'], 'x') == false, "['x', 'y', 'z'] includes 'x', which is not less than 'x'");

  // Test with empty array (should be vacuously true)
  assert(isAllLess!int([], 10) == true, "Empty array should return true (vacuously true)");
}
// #endregion isLess

// #region isLessEqual
// all values in array are less to value
bool isAllLessEqual(T)(T[] values, T compare) {
  return values.all!(value => value.isLessEqual(compare));
}

bool isAnyLessEqual(T)(T[] values, T compare) {
  return values.any!(value => value.isLessEqual(compare));
}

bool isLessEqual(T)(T value, T compare) {
  return (value <= compare);
}

unittest { // isLessEqual(T)(T base, T value)
  // Test isLessEqual with integers
  assert(isLessEqual(3, 5) == true, "3 <= 5 should be true");
  assert(isLessEqual(5, 3) == false, "5 <= 3 should be false");
  assert(isLessEqual(5, 5) == true, "5 <= 5 should be true");

  // Test isLessEqual with floating point numbers
  assert(isLessEqual(1.5, 2.5) == true, "1.5 <= 2.5 should be true");
  assert(isLessEqual(2.5, 1.5) == false, "2.5 <= 1.5 should be false");
  assert(isLessEqual(2.5, 2.5) == true, "2.5 <= 2.5 should be true");

  // Test isLessEqual with characters
  assert(isLessEqual('a', 'b') == true, "'a' <= 'b' should be true");
  assert(isLessEqual('b', 'a') == false, "'b' <= 'a' should be false");
  assert(isLessEqual('a', 'a') == true, "'a' <= 'a' should be true");
}

unittest { // bool isAnyLessEqual(T)(T[] values, T compare)
  // Test isAnyLessEqual with integers
  assert(isAnyLessEqual([1, 2, 3], 2) == true, "[1, 2, 3] has elements <= 2");
  assert(isAnyLessEqual([4, 5, 6], 3) == false, "[4, 5, 6] has no elements <= 3");
  assert(isAnyLessEqual([2, 2, 2], 2) == true, "[2, 2, 2] all elements <= 2");

  // Test isAnyLessEqual with floating point numbers
  assert(isAnyLessEqual([1.5, 2.5, 3.5], 2.5) == true, "[1.5, 2.5, 3.5] has elements <= 2.5");
  assert(isAnyLessEqual([3.5, 4.5, 5.5], 3.0) == false, "[3.5, 4.5, 5.5] has no elements <= 3.0");
  assert(isAnyLessEqual([2.5, 2.5, 2.5], 2.5) == true, "[2.5, 2.5, 2.5] all elements <= 2.5");

  // Test isAnyLessEqual with characters
  assert(isAnyLessEqual(['a', 'b', 'c'], 'b') == true, "['a', 'b', 'c'] has elements <= 'b'");
  assert(isAnyLessEqual(['d', 'e', 'f'], 'c') == false, "['d', 'e', 'f'] has no elements <= 'c'");
  assert(isAnyLessEqual(['b', 'b', 'b'], 'b') == true, "['b', 'b', 'b'] all elements <= 'b'");

  // Test with empty array
  assert(isAnyLessEqual!int([], 1) == false, "Empty array should return false");
}

unittest { // bool isAllLessEqual(T)(T[] values, T compare)
  // Test isAllLessEqual with integers
  assert(isAllLessEqual([1, 2, 3], 3) == true, "[1, 2, 3] all elements <= 3");
  assert(isAllLessEqual([1, 2, 4], 3) == false, "[1, 2, 4] includes 4, which is not <= 3");
  assert(isAllLessEqual([2, 2, 2], 2) == true, "[2, 2, 2] all elements <= 2");

  // Test isAllLessEqual with floating point numbers
  assert(isAllLessEqual([1.1, 2.2, 3.3], 3.3) == true, "[1.1, 2.2, 3.3] all elements <= 3.3");
  assert(isAllLessEqual([1.1, 2.2, 4.4], 3.3) == false, "[1.1, 2.2, 4.4] includes 4.4, which is not <= 3.3");
  assert(isAllLessEqual([2.5, 2.5, 2.5], 2.5) == true, "[2.5, 2.5, 2.5] all elements <= 2.5");

  // Test isAllLessEqual with characters
  assert(isAllLessEqual(['a', 'b', 'c'], 'c') == true, "['a', 'b', 'c'] all elements <= 'c'");
  assert(isAllLessEqual(['a', 'b', 'd'], 'c') == false, "['a', 'b', 'd'] includes 'd', which is not <= 'c'");
  assert(isAllLessEqual(['b', 'b', 'b'], 'b') == true, "['b', 'b', 'b'] all elements <= 'b'");

  // Test with empty array (should be vacuously true)
  assert(isAllLessEqual!int([], 10) == true, "Empty array should return true (vacuously true)");
}
// #endregion isLessEqual

// #region isAll
bool isAll(T)(T[] values, bool delegate(T value) @safe check) {
  return values.all!(value => check(value));
}

unittest {
  assert([1, 2, 3].isAll((int value) => value > 0));

  int checkValue = 100;
  assert([1, 2, 3].isAll((int value) => value < checkValue));
} 
// #endregion isAll

// #region isAll
bool isAny(T)(T[] values, bool delegate(T value) @safe check) {
  return values.any!(value => check(value));
}

unittest {
  assert([1, 2, 3].isAny((int value) => value > 0));

  int checkValue = 100;
  assert([1, 2, 3].isAny((int value) => value < checkValue));
} 
// #endregion isAll

T[] convert(K, V, T)(V[K] items, T delegate(K key, V value) @safe func) {
  return items.byKeyValue.map!(kv => func(kv.key, kv.value)).array;
}

unittest {
  assert(["a":"b"].convert((string key, string value) => key~value) == ["ab"]);
  assert(["a":"b", "c":"d"].convert((string key, string value) => key~value) == ["cd", "ab"]);
} 
