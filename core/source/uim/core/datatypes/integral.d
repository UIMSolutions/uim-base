/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.datatypes.integral;

import uim.core;

mixin(Version!("test_uim_core"));
@safe:

/// convert integral values to string with defined length
/* string toString(T)(T value, size_t length = 0, string fillTxt = "0")
    if (isIntegral!T) {
  string result = fill(length, fillTxt);

  import std.conv;

  string convert = to!string(value);
  return convert.length < length
    ? result[0 .. $ - convert.length] ~ convert : convert;
}

version (test_uim_core) {
  unittest {
    assert(1.toString == "1");
    assert(1.toString == "1");
    assert(1.toString(10, "X") == "XXXXXXXXX1");
  }
}
 */
/// limits the value on the min or max 
T limits(T)(T value, T minLimit, T maxLimit) if (isIntegral!T)
in (minLimit < maxLimit, "minLimit should not be equal or greater then maxLimit")
do {
  T result = value;

  if (minLimit > result)
    result = minLimit;
  if (result > maxLimit)
    result = maxLimit;

  return result;
}

unittest {
  assert(10.limit(2, 8) == 8);
  assert(10.limit(12, 13) == 12);
  assert(10.limit(13, 13) > 0);
  assert(10.limit(14, 13) > 0);
}

/// transform value minOld/maxOld to newMin/newMax 
T transform(T)(T value, T minOld, T maxOld, T newMin, T newMax) if (isIntegral!T)
in ((value >= minOld) && (value <= maxOld), "value should be between minOld and maxOld")
in (minOld < maxOld, "minOld should not be equal or greater then maxOld")
in (newMin != newMax, "newMin should not equal to newMax")
in (newMin < newMax, "newMin should not be equl or greater then newMax")
do {
  T deltaOld = maxOld - minOld;
  T deltaNew = newMax - newMin;
  T result = to!T(newMin + (deltaNew * ((100 * (value - minOld)) / deltaOld)) / 100);

  return result;
}

unittest {
  assert(8.transform(0, 10, 0, 100) == 80);
  assert(80.transform(0, 100, 0, 10) == 8);
}

pure bool isLess(T)(T base, T[] values) {
  return values.filter!(v => base >= v).count == 0;
}

unittest {
  assert(8.isLess([10, 100]));
  assert(!80.isLess([10, 100]));
}

pure bool isGreater(T)(T base, T[] values) {
  return values.filter!(v => base <= v).count == 0;
}

unittest {
  assert(800.isGreater([10, 100]));
  assert(!80.isGreater([10, 100]));
}
