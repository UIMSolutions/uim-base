module uim.oop.helpers.path;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

// #region key-path conversion
// Converts a key string to a path array using the specified separator.
string toPath(string key, string separator = ".") {
  return key.split(separator).map!(k => k.trim).array;
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
