/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.containers.arrays.filter;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:


/**
 * Filters the elements of the input array `values` using the provided `check` delegate.
 *
 * Params:
 *   values = The array of elements to filter.
 *   check = A delegate that takes an element of type `T` and returns `true` if the element should be included in the result.
 *
 * Returns:
 *   A new array containing only the elements from `values` for which `check` returns `true`.
 */
T[] filterValues(T)(T[] values, bool delegate(T value) check) {
  T[] results;
  () @trusted { results = values.filter!(value => check(value)).array; }();
  return results;
}
///
unittest {
    // Test with integers: filter even numbers
    int[] arr = [1, 2, 3, 4, 5, 6];
    auto evens = filterValues(arr, (int v) => v % 2 == 0);
    assert(evens == [2, 4, 6]);

    // Test with integers: filter odd numbers
    auto odds = filterValues(arr, (int v) => v % 2 != 0);
    assert(odds == [1, 3, 5]);

    // Test with integers: filter numbers greater than 4
    auto gtFour = filterValues(arr, (int v) => v > 4);
    assert(gtFour == [5, 6]);

    // Test with integers: filter none
    auto none = filterValues(arr, (int v) => false);
    assert(none.length == 0);

    // Test with integers: filter all
    auto all = filterValues(arr, (int v) => true);
    assert(all == arr);

    // Test with empty array
    int[] emptyArr;
    auto emptyResult = filterValues(emptyArr, (int v) => true);
    assert(emptyResult.length == 0);

    // Test with strings: filter by length
    string[] words = ["cat", "dog", "elephant", "ant"];
    auto longWords = filterValues(words, (string w) => w.length > 3);
    assert(longWords == ["elephant"]);

    // Test with strings: filter by prefix
    auto startsWithA = filterValues(words, (string w) => w.startsWith("a"));
    assert(startsWithA == ["ant"]);

    // Test with strings: filter none
    auto noMatch = filterValues(words, (string w) => w == "zebra");
    assert(noMatch.length == 0);

    // Test with strings: filter all
    auto allWords = filterValues(words, (string w) => true);
    assert(allWords == words);
}

/**
 * Filters the elements of the input array `values`, returning only those that are present in the `validValues` array.
 *
 * Params:
 *   values = The array of elements to filter.
 *   validValues = An array of valid elements. Only elements from `values` that are also in `validValues` will be included in the result.
 *
 * Returns:
 *   A new array containing only the elements from `values` that are also present in `validValues`.
 *   If `validValues` is empty, the original `values` array is returned.
 */
T[] filterValues(T)(T[] values, T[] validValues) {
  if (values.length == 0) { return null; }

  return validValues.length == 0
    ? values.dup 
    : values.filter!(value => validValues.has(value)).array;
}
///
unittest {
    // Test: values is empty, should return baseArray unchanged
    int[] base = [1, 2, 3, 4, 5];
    int[] values = [];
    auto result = filterValues(base, values);
    assert(result == base);

    // Test: values contains some elements of baseArray
    int[] vals = [2, 4];
    result = filterValues(base, vals);
    assert(result == [2, 4]);

    // Test: values contains all elements of baseArray
    vals = [1, 2, 3, 4, 5];
    result = filterValues(base, vals);
    assert(result == base);

    // Test: values contains none of the elements of baseArray
    vals = [10, 20];
    result = filterValues(base, vals);
    assert(result.length == 0);

    // Test: baseArray is empty
    base = [];
    vals = [1, 2, 3];
    result = filterValues(base, vals);
    assert(result.length == 0);

    // Test: both baseArray and values are empty
    base = [];
    vals = [];
    result = filterValues(base, vals);
    assert(result.length == 0);

    // Test: with strings
    string[] strBase = ["apple", "banana", "cherry"];
    string[] strVals = ["banana", "cherry"];
    auto strResult = filterValues(strBase, strVals);
    assert(strResult == ["banana", "cherry"]);

    // Test: string values not in baseArray
    strVals = ["orange", "pear"];
    strResult = filterValues(strBase, strVals);
    assert(strResult.length == 0);

    // Test: string values is empty
    strVals = [];
    strResult = filterValues(strBase, strVals);
    assert(strResult == strBase);

    // Test: string baseArray is empty
    strBase = [];
    strVals = ["banana"];
    strResult = filterValues(strBase, strVals);
    assert(strResult.length == 0);
}