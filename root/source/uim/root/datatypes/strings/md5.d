/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.strings.md5;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

/** Calculates the MD5 hash for each string in the given array of strings.

    Params:
        values = An array of strings to calculate the MD5 hash for.

    Returns:
        An array of MD5 hash strings corresponding to each input string.
*/
string[] md5(string[] values) {
  return values.map!(value => md5(value)).array;
}
///
unittest {
  auto result = md5(["hello", "world"]);
  assert(result.length == 2);
  assert(result[0] == "5d41402abc4b2a76b9719d911017c592");
  assert(result[1] == "7d793037a0760186574b0282f2f435e7");
}

/** 
  Calculates the MD5 hash for the given string.

  Params:
      value = The string to calculate the MD5 hash for.

  Returns:
      The MD5 hash string of the input string.
*/
string md5(string value) {
  import std.digest.md;

  return toHexString(md5Of(value).dup);
}
///
unittest {
  assert(md5("hello") == "5d41402abc4b2a76b9719d911017c592");
  assert(md5("world") == "7d793037a0760186574b0282f2f435e7");
}