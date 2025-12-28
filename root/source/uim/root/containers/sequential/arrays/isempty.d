/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.containers.arrays.isempty;

import uim.root;

mixin(Version!("test_uim_phobos"));
@safe:

/** 
  * Checks if the given array is empty.
  *
  * Params:
  *   values = The array to check.
  *
  * Returns:
  *   `true` if the array is empty, `false` otherwise.
  *
  * Examples:
  * ```d
  * int[] array1;
  * assert(isEmpty(array1)); // true
  *
  * int[] array2 = [1, 2, 3];
  * assert(!isEmpty(array2)); // false
  * ```
  */
bool isEmpty(T)(T[] values) {
  return values.length == 0;
}
///
unittest {
  // Test with empty int array
  int[] array1;
  assert(isEmpty(array1));

  // Test with non-empty int array
  int[] array2 = [1, 2, 3];
  assert(!isEmpty(array2));

  // Test with empty string array
  string[] arr3;
  assert(isEmpty(arr3));

  // Test with non-empty string array
  string[] arr4 = ["a", "b"];
  assert(!isEmpty(arr4));

  // Test with empty array of structs
  struct S {
    int x;
  }

  S[] arr5;
  assert(isEmpty(arr5));

  // Test with non-empty array of structs
  S[] arr6 = [S(1), S(2)];
  assert(!isEmpty(arr6));
}
