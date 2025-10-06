/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.arrays.first;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

// #region first(T)(T value) if (!isArray!T)
auto first(T)(T value) if (!isArray!T) {
  return value;
}
unittest {
    // Test for non-array types
    assert(first(123) == 123);           // int
    assert(first(3.14) == 3.14);         // double
    assert(first('a') == 'a');           // char
    assert(first(true) == true);         // bool

    struct S { int a; }
    S s = S(5);
    assert(first(s) == s);               // struct

    enum E { A, B, C }
    assert(first(E.B) == E.B);           // enum

    // Test for reference types
    class C { int x = 7; }
    auto c = new C;
    assert(first(c) is c);               // class reference

    // Test for pointer types
    int i = 42;
    int* p = &i;
    assert(first(p) is p);               // pointer

    // Test for associative array (not an array type in D)
    int[string] aa = ["one": 1, "two": 2];
    assert(first(aa) is aa);

    // Test for delegate
    int delegate() dg = () => 5;
    assert(first(dg) is dg);

    // Test for function pointer
    int function() fp = () => 6;
    assert(first(fp) is fp);
}
// #endregion first(T)(T value) if (!isArray!T)

auto first(T)(T value) if (isArray!T) {
  return value.length > 0 
  ? value[0]
  : Null!T;
}

auto first(T : string)(T value) {
  return value;
}