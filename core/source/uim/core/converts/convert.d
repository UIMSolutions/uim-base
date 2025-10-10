module uim.core.converts.convert;

import uim.core;

mixin(Version!("test_uim_core"));
@safe:

T[] convert(T, V)(V[] values, T delegate(V value) @safe converter) {
  return !values || values.length == 0
  ? null
  : values.map!(value => converter(value)).array;
}
///
unittest {
  import uim.core.converts.long_;

  auto values = [1L, 2L, 3L];
  auto result = convert!string(values, (long value) => value.toString);
  assert(result == ["1", "2", "3"]);

  values = [];
  result = convert!string(values, (long value) => value.toString);
  assert(result == null);

  values = null;
  result = convert!string(values, (long value) => value.toString);
  assert(result == null);
}

T[] convert(T, K, V)(V[K] values, T delegate(K key,V value) @safe converter) {
  return !values || values.length == 0
  ? null
  : values.byKeyValue.map!(kv => converter(kv.key, kv.value)).array;
}

unittest {
    // Test with int[string] associative array
    int[string] values = ["a": 1, "b": 2, "c": 3];
    auto result = convert!string(values, (string key, int value) => key ~ ":" ~ to!string(value));
    assert(result.sort == ["a:1", "b:2", "c:3"].sort);

    // Test with empty associative array
    values = null;
    result = convert!string(values, (string key, int value) => key ~ ":" ~ to!string(value));
    assert(result == null);

    // Test with null associative array
    values = null;
    result = convert!string(values, (string key, int value) => key ~ ":" ~ to!string(value));
    assert(result == null);

    // Test with double[int] associative array
    double[int] dvalues = [1: 1.5, 2: 2.5];
    auto dresult = convert!string(dvalues, (int key, double value) => key.to!string ~ "=" ~ value.to!string);
    assert(dresult.sort == ["1=1.5", "2=2.5"].sort);

    // Test with bool[char] associative array
    bool[char] bvalues = ['x': true, 'y': false];
    auto bresult = convert!string(bvalues, (char key, bool value) => key ~ (value ? "T" : "F"));
    assert(bresult.sort == ["xT", "yF"].sort);
}