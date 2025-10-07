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

// #region first(T)(T value) if (isArray!T)
auto first(T)(T[] value) {
  return value.length > 0 
  ? value[0]
  : Null!T;
}
unittest {
    // Test: non-empty int array
    int[] arr = [1, 2, 3];
    assert(first(arr) == 1);

    // Test: empty int array
    int[] emptyArr;
    // assert(first(emptyArr).isNull);

    // Test: non-empty double array
    double[] darr = [4.2, 5.3];
    assert(first(darr) == 4.2);

    // Test: empty double array
    double[] emptyDarr;
    writeln("Empty double array first: ", first(emptyDarr));
    writeln("Empty double : ", double.init);
    // assert(first(emptyDarr).isNull);

    // Test: non-empty string array
    string[] strArr = ["alpha", "beta"];
    assert(first(strArr) == "alpha");

    // Test: empty string array
    string[] emptyStrArr;
    // assert(first(emptyStrArr).isNull);

    // Test: non-empty array of structs
    // struct S { int x; }
    // S[] sArr = [S(10), S(20)];
    // assert(first(sArr) == S(10));

    // Test: empty array of structs
    // S[] emptySArr;
    // assert(first(emptySArr) == S.init);

    // Test: non-empty array of bools
    bool[] bArr = [true, false];
    assert(first(bArr) == true);

    // Test: empty array of bools
    bool[] emptyBArr;
    // assert(first(emptyBArr).isNull);
}
// #region first(T)(T value) if (isArray!T)

// #region first(T : string)(T value)
auto first(T : string)(T value) {
  return value;
}
unittest {
    // Test: non-empty string
    string s = "hello";
    assert(first(s) == "hello");

    // Test: empty string
    string empty = "";
    assert(first(empty) == "");

    // Test: string with whitespace
    string ws = "   ";
    assert(first(ws) == "   ");

    // Test: string with unicode characters
    string unicode = "üñîçødë";
    assert(first(unicode) == "üñîçødë");

    // Test: string literal
    assert(first("literal") == "literal");

    // Test: multi-line string
    string multiLine = `line1
line2`;
    assert(first(multiLine) == `line1
line2`);    

    // Test: string with escape sequences
    string escapeSeq = "line1\nline2\tend";
    assert(first(escapeSeq) == "line1\nline2\tend");

    // Test: very long string
    string longStr = "a".repeat(1000).join;
    assert(first(longStr) == longStr);

    // Test: string with embedded null character
    string withNull = "abc\0def";
    assert(first(withNull) == "abc\0def");
    // Test: string with leading and trailing spaces
    assert(first("  spaced  ") == "  spaced  ");
    
    
    assert(first(["literal", " "]) == "literal");
}
// #endregion first(T : string)(T value)
