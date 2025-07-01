/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.algorithm.searchings;

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
  assert(duplicates!int(null, 1) == 0);

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

// #region contains
// #region containsAll
bool containsAll(string[] bases, string[] values) {
  return bases.all!(base => base.containsAll(values));
}

bool containsAll(string base, string[] values) {
  return values.all!(value => base.contains(value));
}
// #endregion containsAll

// #region containsAny
bool containsAny(string[] bases, string[] values) {
  return bases.any!(base => base.containsAny(values));
}

bool containsAny(string base = null, string[] values = null) {
  if (values is null) {
    return false;
  }
  if (base.length == 0 || values.length == 0) {
    return false;
  }
  return values.any!(value => base.contains(value));
}
// #endregion containsAny

bool contains(string text, string checkValue) {
  return (text.length == 0 || checkValue.length == 0 || checkValue.length > text.length)
    ? false : text.canFind(checkValue);
}

unittest { // bool contains(string text, string checkValue)
  // Test with both strings empty
  assert(!contains("", ""));

  // Test with text empty and checkValue non-empty
  assert(!contains("", "test"));

  // Test with text non-empty and checkValue empty
  assert(!contains("test", ""));

  // Test with checkValue longer than text
  assert(!contains("short", "longer"));

  // Test with checkValue equal to text
  assert(contains("exact", "exact"));

  // Test with checkValue being a substring of text
  assert(contains("hello world", "world"));

  // Test with checkValue not being a substring of text
  assert(!contains("hello world", "planet"));

  // Test with special characters
  assert(contains("hello@world.com", "@world"));
  assert(!contains("hello@world.com", "@planet"));

  // Test with case sensitivity
  assert(!contains("Hello World", "hello"));
  assert(contains("Hello World", "World"));

  // Test with numeric characters
  assert(contains("1234567890", "456"));
  assert(!contains("1234567890", "9876"));

  // Test with whitespace
  assert(contains("   leading spaces", "leading"));
  assert(!contains("   leading spaces", "trailing"));
}

unittest { // bool containsAny(string base, string[] values)
  // Test with an empty base string and empty values array
  assert(!containsAny("", null));

  // Test with an empty base string and non-empty values array
  assert(!containsAny("", ["test", "value"]));

  // Test with a non-empty base string and empty values array
  assert(!containsAny("test", null));

  // Test with a base string containing one of the values
  assert(containsAny("hello world", ["world", "planet"]));

  // Test with a base string containing none of the values
  assert(!containsAny("hello world", ["planet", "galaxy"]));

  // Test with a base string containing all the values
  assert(containsAny("hello world", ["hello", "world"]));

  // Test with special characters
  assert(containsAny("hello@world.com", ["@", ".com"]));
  assert(!containsAny("hello@world.com", ["#"]));

  // Test with case sensitivity
  assert(!containsAny("Hello World", ["hello", "planet"]));
  assert(containsAny("Hello World", ["World", "planet"]));

  // Test with numeric characters
  assert(containsAny("1234567890", ["456", "789"]));
  assert(!containsAny("1234567890", ["987", "654"]));

  // Test with whitespace
  assert(containsAny("   leading spaces", ["leading", "spaces"]));
  assert(!containsAny("   leading spaces", ["trailing", "middle"]));
}

unittest { // bool containsAny(string[] bases, string[] values)
  // Test with a base array containing one string that matches one of the values
  assert(containsAny(["hello world", "example"], ["world", "planet"]));

  // Test with a base array where none of the strings match any of the values
  assert(!containsAny(["hello world", "example"], ["planet", "galaxy"]));

  // Test with a base array where all strings match at least one value
  assert(containsAny(["hello world", "example"], ["hello", "example"]));

  // Test with special characters in bases and values
  assert(containsAny(["hello@world.com", "example"], ["@", ".com"]));
  assert(!containsAny(["hello@world.com", "example"], ["#"]));

  // Test with case sensitivity
  assert(!containsAny(["Hello World", "Example"], ["hello", "planet"]));
  assert(containsAny(["Hello World", "Example"], ["World", "planet"]));

  // Test with numeric characters in bases and values
  assert(containsAny(["1234567890", "example"], ["456", "789"]));
  assert(!containsAny(["1234567890", "example"], ["987", "654"]));

  // Test with whitespace in bases and values
  assert(containsAny(["   leading spaces", "example"], ["leading", "spaces"]));
  assert(!containsAny(["   leading spaces", "example"], ["trailing", "middle"]));
}
// #endregion contains
