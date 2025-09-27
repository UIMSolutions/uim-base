/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.helpers.path;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

// #region key-path conversion
// Converts a key string to a path array using the specified separator.
string[] toPath(string key, string separator = ".") {
  return key.split(separator).correctPath;
}

unittest {
  // Test 1: Basic usage with default separator
  string key1 = "foo.bar.baz";
  assert(toPath(key1) == ["foo", "bar", "baz"]);

  // Test 2: Custom separator
  string key2 = "foo/bar/baz";
  assert(toPath(key2, "/") == ["foo", "bar", "baz"]);

  // Test 3: Key with whitespace
  string key3 = " foo . bar . baz ";
  assert(toPath(key3) == ["foo", "bar", "baz"]);

  // Test 4: Empty key
  string key4 = "";
  assert(toPath(key4) == [""]);

  // Test 5: Key with consecutive separators
  string key5 = "foo..baz";
  assert(toPath(key5) == ["foo", "", "baz"]);
}
// #endregion key-path conversion

// #region correct path
// Corrects a path array by trimming whitespace from each segment.
string[] correctPath(string[] path) {
  return path.map!(p => p.strip).array;
}
unittest {
  // Test 1: Basic usage
  string[] path1 = [" foo ", " bar ", " baz "];
  assert(correctPath(path1) == ["foo", "bar", "baz"]);

  // Test 2: Path with empty segments
  string[] path2 = [" foo ", "", " baz "];
  assert(correctPath(path2) == ["foo", "", "baz"]);

  // Test 3: Path with all whitespace segments
  string[] path3 = ["   ", " bar ", "   "];
  assert(correctPath(path3) == ["", "bar", ""]);

  // Test 4: Empty path
  string[] path4 = [];
  assert(correctPath(path4) == []);
}
// #endregion correct path