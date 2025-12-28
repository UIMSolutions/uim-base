/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.strings.mutation;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:



// #region stripTextLeft
string[] stripTextLeft(string[] texts, string[] stripchars = null) {
  return texts
    .map!(text => stripTextLeft(text, stripchars))
    .array;
}

string stripTextLeft(string text, string[] stripchars = null) {
  if (text.isEmpty) {
    return null;
  }
  if (stripchars.isEmpty) {
    return stripLeft(text);
  }
  foreach (c; stripchars) {
    text = stripLeft(text, c);
  }
  return text;
}

unittest {
  writeln("Testing stripTextLeft()");

  assert("a".stripTextLeft == "a");
  assert(" a".stripTextLeft == "a");
  assert("a ".stripTextLeft == "a ");
  assert(" a ".stripTextLeft == "a ");

  assert("a".stripTextLeft(["."]) == "a");
  assert(" a".stripTextLeft(["."]) == " a");
  assert("a ".stripTextLeft(["."]) == "a ");
  assert(" a ".stripTextLeft(["."]) == " a ");

  assert(["a", "b", "c"].stripTextLeft == ["a", "b", "c"]);
  assert([" a", "b ", " c "].stripTextLeft == ["a", "b ", "c "]);
  assert([".a", "b.", ".c."].stripTextLeft(["."]) == ["a", "b.", "c."]);
}
// #endregion stripTextLeft

// #region stripTextRight
string[] stripTextRight(string[] texts, string[] stripchars = null) {
  return texts
    .map!(text => stripTextRight(text, stripchars))
    .array;
}

string stripTextRight(string text, string[] stripchars = null) {
  if (text.isEmpty) {
    return null;
  }
  if (stripchars.isEmpty) {
    return stripRight(text);
  }
  foreach (c; stripchars) {
    text = stripRight(text, c);
  }
  return text;
}

unittest {
  assert("a".stripTextRight == "a");
  assert(" a".stripTextRight == " a");
  assert("a ".stripTextRight == "a");
  assert(" a ".stripTextRight == " a");

  assert("a".stripTextRight(["."]) == "a");
  assert(" a".stripTextRight(["."]) == " a");
  assert("a ".stripTextRight(["."]) == "a ");
  assert(" a ".stripTextRight(["."]) == " a ");
}
// #endregion stripTextRight

