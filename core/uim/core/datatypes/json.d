module uim.core.datatypes.json;

mixin(Version!("test_uim_core"));

import uim.core;
@safe:

// #region intersect 
T[] intersect(T)(T[] left, Json right) {
  return right.isArray
    ? intersect(left, right.getArray)
    : null;
}

T[] intersect(T)(T[] left, Json[] values) {
  return right.isArray
    ? intersect(left, values.map!(value => value.get!T).array)
    : null;
}

unittest {
  assert(intersect(["a", "b", "c"], ["a"]) == ["a"]);
  Json json = Json.emptyArray;
  json ~= "a";
  // assert(intersect(["a", "b", "c"], json) == ["a"]);
}
// #endregion intersect 

// #region shift
T shift(T:Json)(auto ref T[] values) {
  switch (values.length) {
  case 0:
    return Json(null);
  case 1:
    T value = values[0];
    values = Json.emptyArray;
    return value;
  default:
    T value = values[0];
    values = values[1 .. $].dup;
    return value;
  }
}

unittest {
  /* string[] testValues;
  assert(testValues.shift is null);

  testValues = ["a"];
  assert(testValues.length == 1);
  assert(testValues.shift == "a");
  assert(testValues.length == 0);

  testValues = ["a", "b", "c"];
  assert(testValues.length == 3);
  assert(testValues.shift == "a");
  assert(testValues.length == 2); */
}
// #endregion shift