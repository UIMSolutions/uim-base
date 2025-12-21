/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.phobos.datatypes.strings.mutation;

import uim.phobos;
@safe:

// #region lower
/**
  * Converts all characters in the given texts to lower case.
  *
  * Params:
  *   texts = The texts to convert to lower case.
  *
  * Returns:
  *   An array of texts converted to lower case.
  */
string[] lower(string[] texts) {
  return texts
    .map!(text => text.toLower)
    .array;
}

/** 
  * Converts all characters in the given text to lower case.
  *
  * Params:
  *   text = The text to convert to lower case.
  *
  * Returns:
  *   The text converted to lower case.
  */
string lower(string text) {
  return text.toLower;
}

// #endregion lower

// #region stripText
string[] stripText(string[] texts, string[] stripchars= null) {
  return texts
    .map!(text => stripText(text, stripchars))
    .array;
}

string stripText(string text, string[] stripchars = null) {
  if (text.isEmpty) {
    return null;
  }
  if (stripchars.isEmpty) {
    return text.strip;
  }
  foreach (c; stripchars) {
    text = text.strip(c);
  }
  return text;
}

unittest {
  writeln("Testing stripText()");

  assert("a".stripText == "a");
  assert(" a".stripText == "a");
  assert("a ".stripText == "a");
  assert(" a ".stripText == "a");

  assert("a".stripText(["."]) == "a");
  assert(" a".stripText(["."]) == " a");
  assert("a ".stripText(["."]) == "a ");
  assert(" a ".stripText(["."]) == " a ");

  assert(["a", "b", "c"].stripText == ["a", "b", "c"]);
  assert([" a", "b ", " c "].stripText == ["a", "b", "c"]);
  assert([".a", "b.", ".c."].stripText(["."]) == ["a", "b", "c"]);
}
// #endregion stripText

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

// #region upper
string[] upper(string[] texts) {
  return texts
    .map!(text => text.toUpper)
    .array;
}

string upper(string text) {
  return text.toUpper;
}

unittest {
  assert("a".upper == "A");
  assert(["a", "b", "c"].upper.equal(["A", "B", "C"]));
}
// #endregion upper
