/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.convert.convert;

mixin(Version!("test_uim_phobos"));

import uim.phobos;

@safe:

// #region toString
/* string toString(T)(T value, size_t length = 0, string fillTxt = "0") {
//    if (isFloatingPoint!T) {
  string result = fill(length, fillTxt);

  import std.conv;

  string convert = to!string(value);
  result = convert.length < length
    ? result[0 .. $ - convert.length] ~ convert : convert;

  return result;
} */

unittest {
  // TODO
  // writeln((1.01).toString);
  //   assert((1.0).toString == "1.0");
  //   assert((1.0).toString == "1.0");
  //   assert((1.0).toString(10, "X") == "XXXXXXX1.0");
}

// #endregion toString

string toString(short value) {
  return to!string(value);
}

string toString(int value) {
  return to!string(value);
}

string toString(long value) {
  return to!string(value);
}

string toString(double value) {
  return to!string(value);
}

string toString(T)(T[] values) {
  return "[" ~ values.map!(value => value.toString).join(",") ~ "]";
}

string toString(T : string)(T[] values) {
  return "[" ~ values.map!(value => `"` ~ value ~ `"`).join(",") ~ "]";
}

unittest {
  writeln([1, 2, 3].toString);
}