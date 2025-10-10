/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.phobos.containers.arrays.first;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

/** 
  * Returns the first element of the array or a Null!T if the array is empty.
  * 
  * Params:
  *   values = The array to get the first element from.
  * 
  * Returns:
  *   The first element of the array or a Null!T if the array is empty.
  */
T first(T)(T[] values) pure {
  return values.length > 0
    ? values[0] : Null!T;
}
///
unittest {
  // Test: first with non-empty int array
  int[] arr1 = [42, 7, 13];
  auto res1 = first(arr1);
  assert(res1 == 42);

  // Test: first with empty int array
  int[] arr2 = [];
  auto res2 = first(arr2);
  assert(res2 == Null!int);

  // Test: first with non-empty string array
  string[] arr3 = ["hello", "world"];
  auto res3 = first(arr3);
  assert(res3 == "hello");

  // Test: first with empty string array
  string[] arr4 = [];
  auto res4 = first(arr4);
  assert(res4 == Null!string);

  // Test: first with single-element array
  double[] arr5 = [3.14];
  auto res5 = first(arr5);
  assert(res5 == 3.14);

  // Test: first with empty double array
  double[] arr6 = [];
  auto res6 = first(arr6);
  assert(res6 == Null!double);
}

/** 
  * Returns an array containing the first 'size' elements of the input array.
  * If the input array has fewer than 'size' elements, returns a duplicate of the entire array.
  * If the input array is empty, returns null.
  * 
  * Params:
  *   values = The array to extract elements from.
  *   numberOfValues = The number of elements to extract from the start of the array.
  * 
  * Returns:
  *   An array containing the first 'numberOfValues' elements, a duplicate of the entire array if it has fewer than 'numberOfValues' elements, or null if the array is empty.
  */
T[] firstMany(T)(T[] values, size_t numberOfValues) pure nothrow {
  if (values.length == 0) {
    return null;
  }

  return values.length > numberOfValues
    ? values[0 .. numberOfValues].dup
    : values.dup;
}
///
unittest {
  // Test: firstMany with size less than array length
  int[] arr1 = [10, 20, 30, 40, 50];
  auto res1 = firstMany(arr1, 3);
  assert(res1.equal([10, 20, 30]));

  // Test: firstMany with size equal to array length
  int[] arr2 = [1, 2, 3];
  auto res2 = firstMany(arr2, 3);
  assert(res2.equal([1, 2, 3]));

  // Test: firstMany with size greater than array length
  int[] arr3 = [7, 8];
  auto res3 = firstMany(arr3, 5);
  assert(res3.equal([7, 8]));

  // Test: firstMany with empty array
  int[] arr4 = [];
  auto res4 = firstMany(arr4, 2);
  assert(res4.isEmpty);

  // Test: firstMany with size zero
  int[] arr5 = [1, 2, 3];
  auto res5 = firstMany(arr5, 0);
  writeln("res5: ", res5);
  assert(res5.isEmpty);

  // Test: firstMany with strings
  string[] arr6 = ["a", "b", "c", "d"];
  auto res6 = firstMany(arr6, 2);
  assert(res6.equal(["a", "b"]));
}

/**
  * Returns an array of elements from the input array that are present in the anyValues array.
  * 
  * Params:
  *   values = The array to filter.
  *   anyValues = The array containing values to match against.
  * 
  * Returns:
  *   An array of elements from values that are also in anyValues.
  */
T[] firstAny(T)(T[] values, T[] anyValues) {
  return values.filter!(value => anyValues.has(value)).array;
}
///
unittest {
  // Test: firstAny with some matching values
  int[] values = [1, 2, 3, 4, 5];
  int[] anyValues = [2, 4, 6];
  auto result = firstAny(values, anyValues);
  assert(result.equal([2, 4]));

  // Test: firstAny with no matching values
  int[] values2 = [7, 8, 9];
  int[] anyValues2 = [1, 2, 3];
  auto result2 = firstAny(values2, anyValues2);
  assert(result2.length == 0);

  // Test: firstAny with all matching values
  int[] values3 = [1, 2, 3];
  int[] anyValues3 = [1, 2, 3];
  auto result3 = firstAny(values3, anyValues3);
  assert(result3.equal([1, 2, 3]));

  // Test: firstAny with empty values
  int[] values4 = [];
  int[] anyValues4 = [1, 2, 3];
  auto result4 = firstAny(values4, anyValues4);
  assert(result4.length == 0);

  // Test: firstAny with empty anyValues
  int[] values5 = [1, 2, 3];
  int[] anyValues5 = [];
  auto result5 = firstAny(values5, anyValues5);
  assert(result5.length == 0);

  // Test: firstAny with strings
  string[] values6 = ["apple", "banana", "cherry"];
  string[] anyValues6 = ["banana", "date"];
  auto result6 = firstAny(values6, anyValues6);
  assert(result6.equal(["banana"]));
}
