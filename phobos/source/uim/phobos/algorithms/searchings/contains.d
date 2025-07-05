/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.algorithms.searchings.contains;
import uim.phobos;

@safe:
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
