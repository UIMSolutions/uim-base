/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.helpers.key;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

// #region path-key conversion
// Converts a path array to a key string using the specified separator.
string toKey(string[] path, string separator = ".") {
  return path.map!(p => p.trim).join(separator);
}

unittest {
  // Test 1: Basic usage with default separator
  string[] path1 = ["foo", "bar", "baz"];
  assert(toKey(path1) == "foo.bar.baz");

  // Test 2: Custom separator
  string[] path2 = ["foo", "bar", "baz"];
  assert(toKey(path2, "/") == "foo/bar/baz");

  // Test 3: Path with whitespace
  string[] path3 = [" foo ", " bar", "baz "];
  assert(toKey(path3) == "foo.bar.baz");

  // Test 4: Empty path
  string[] path4 = [];
  assert(toKey(path4) == "");

  // Test 5: Path with empty strings
  string[] path5 = ["", "bar", ""];
  assert(toKey(path5) == ".bar.");
}
// #endregion path-key conversion
