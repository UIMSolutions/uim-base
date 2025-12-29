module uim.root.datatypes.strings.convert;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

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

string toString(string value) {
  return value;
}

string toString(T)(T[] values) {
  return "[" ~ values.map!(value => value.toString).join(",") ~ "]";
}
///
unittest {
    assert(toString(123) == "123");
    assert(toString(123.45) == "123.45");
    assert(toString(["foo", "bar"]) == `["foo","bar"]`);
    assert(toString([1, 2, 3]) == "[1,2,3]");
}
///
unittest {
  assert(toString(["foo", "bar"]) == `["foo","bar"]`);
  assert(toString([1, 2, 3]) == "[1,2,3]");
}