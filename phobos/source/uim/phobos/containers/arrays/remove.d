/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.phobos.containers.arrays.remove;

import uim.phobos;

mixin(Version!("test_uim_phobos"));

@safe:

T[] removeValues(T)(T[] items, size_t[] indices) {
  return items.filter!((_, index) => !indices.contains(index));
}

T[] removeValues(T)(T[] items, bool delegate(T t) @safe removeFunc) {
  return items.removeValues(removeFunc);
}

T[] removeValue(T)(T[] items, size_t index) {
  if (index == 0) {
    return items.length > 1 ? items[1..$] : null; 
  }

  if (index+1 == items.length) {
    return items.length > 1 ? items[0..$-1] : null; 
  }

  return items.length > index ? items[0..index] ~ items[index+1..$] : items;
}

/**
  * Removes the element at the specified index from the array.
  *
  * Params:
  *   values = The original array.
  *   index = The index of the element to remove.
  *
  * Returns:
  *   A new array with the specified element removed.
  */
auto removeAt(T)(T[] values, size_t index) {
  return (index >= values.length) 
  ? values.dup 
  : values.dup.remove(index);
}
///
unittest {
  // Test removing from the middle
  int[] arr = [10, 20, 30, 40, 50];
  auto result = removeAt(arr, 2);
  assert(result == [10, 20, 40, 50]);

  // Test removing first element
  result = arr.removeAt(0);
  assert(result == [20, 30, 40, 50]);

  // Test removing last element
  result = arr.removeAt(arr.length - 1);
  assert(result == [10, 20, 30, 40]);

  // Test removing from single-element array
  int[] single = [42];
  result = single.removeAt(0);
  assert(result.length == 0);
}

/* 
auto removeValue(T)(T[] arr, T value) {
  import std.algorithm : remove;
  import std.array : array;
  return arr.remove(value).array;
}

auto removeAllValue(T)(T[] arr, T[] values) {
  import std.algorithm : remove;
  import std.array : array;
  return arr.remove(values).array;
}

auto removeif(T)(T[] arr, bool delegate(T) dg) {
  import std.algorithm : removeIf;
  import std.array : array;
  return arr.removeIf(dg).array;
}

unittest {
  auto arr = [1, 2, 3, 4, 5];
  auto result1 = removeAt(arr, 2);
  assert(result1 == [1, 2, 4, 5]);

  auto result2 = removeValue(arr, 3);
  assert(result2 == [1, 2, 4, 5]);

  auto result3 = removeAllValue(arr, [2, 4]);
  assert(result3 == [1, 3, 5]);
}
*/
