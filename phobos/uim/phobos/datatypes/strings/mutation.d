module uim.phobos.datatypes.strings.mutation;

import uim.phobos;
@safe:

// #region lower
string[] lower(string[] texts) {
  return texts
    .map!(text => text.toLower)
    .array;
}

string lower(string text) {
  return text.toLower;
}

unittest {
  assert("A".lower == "a");
  assert(["A", "B", "C"].lower.equal(["a", "b", "c"]));
}
// #endregion lower

// #region stripText
string[] stripText(string[] texts, string[] chars) {
  return texts
    .map!(text => stripText(text, chars))
    .array;
}

string stripText(string text, string[] chars) {
  if (text.isEmpty) {
    return null;
  }
  if (chars.isEmpty) {
    return text.strip;
  }
  foreach (c; chars) {
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

  assert("a".stripText(".") == "a");
  assert(" a".stripText(".") == " a");
  assert("a ".stripText(".") == "a ");
  assert(" a ".stripText(".") == " a ");

  assert("a".stripText(".") == "a");
  assert(".a".stripText(".") == "a");
  assert("a.".stripText(".") == "a");
  assert(".a.".stripText(".") == "a");

  assert("a".stripText(".") == "a");
  assert(".a".stripText(".") == "a");
  assert("a.".stripText(".") == "a");
  assert(".a.".stripText(".") == "a");

  assert("a".stripText(" ") == "a");
  assert(".a".stripText(" ") == ".a");
  assert("a.".stripText(" ") == "a.");
  assert(".a.".stripText(" ") == ".a.");

  assert("a".stripText(".", " ") == "a");
  assert(".a ".stripText(".", " ") == "a");
  assert(" a.".stripText(".", " ") == "a");
  assert(" .a. ".stripText(".", " ") == ".a.");
  assert(" .a. ".stripText(" ", ".") == "a");

  assert(["a", "b", "c"].stripText == ["a", "b", "c"]);
  assert([" a", "b ", " c "].stripText == ["a", "b", "c"]);
  assert([".a", "b.", ".c."].stripText(["."]) == ["a", "b", "c"]);
}
// #endregion stripText

// #region stripTextLeft
string[] stripTextLeft(string[] texts, string[] chars) {
  return texts
    .map!(text => stripTextLeft(text, chars))
    .array;
}

string stripTextLeft(string text, string[] chars) {
  if (text.isEmpty) {
    return null;
  }
  if (chars.isEmpty) {
    return stripLeft(text);
  }
  foreach (c; chars) {
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

  assert("a".stripTextLeft(".") == "a");
  assert(" a".stripTextLeft(".") == " a");
  assert("a ".stripTextLeft(".") == "a ");
  assert(" a ".stripTextLeft(".") == " a ");

  assert("a".stripTextLeft(".") == "a");
  assert(".a".stripTextLeft(".") == "a");
  assert("a.".stripTextLeft(".") == "a.");
  assert(".a.".stripTextLeft(".") == "a.");

  assert("a".stripTextLeft(".") == "a");
  assert(".a".stripTextLeft(".") == "a");
  assert("a.".stripTextLeft(".") == "a.");
  assert(".a.".stripTextLeft(".") == "a.");

  assert("a".stripTextLeft(" ") == "a");
  assert(".a".stripTextLeft(" ") == ".a");
  assert("a.".stripTextLeft(" ") == "a.");
  assert(".a.".stripTextLeft(" ") == ".a.");

  assert("a".stripTextLeft(".", " ") == "a");
  assert(".a ".stripTextLeft(".", " ") == "a ");
  assert(" a.".stripTextLeft(".", " ") == "a.");
  assert(" .a. ".stripTextLeft(".", " ") == ".a. ");
  assert(" .a. ".stripTextLeft(" ", ".") == "a. ");

  assert(["a", "b", "c"].stripTextLeft == ["a", "b", "c"]);
  assert([" a", "b ", " c "].stripTextLeft == ["a", "b ", "c "]);
  assert([".a", "b.", ".c."].stripTextLeft(["."]) == ["a", "b.", "c."]);
}
// #endregion stripTextLeft

// #region stripTextRight
string[] stripTextRight(string[] texts, string[] chars) {
  return texts
    .map!(text => stripTextRight(text, chars))
    .array;
}

string stripTextRight(string text, string[] chars) {
  if (text.isEmpty) {
    return null;
  }
  if (chars.isEmpty) {
    return stripRight(text);
  }
  foreach (c; chars) {
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

  assert("a".stripTextRight(".") == "a");
  assert(" a".stripTextRight(".") == " a");
  assert("a ".stripTextRight(".") == "a ");
  assert(" a ".stripTextRight(".") == " a ");

  assert("a".stripTextRight(".") == "a");
  assert(".a".stripTextRight(".") == ".a");
  assert("a.".stripTextRight(".") == "a");
  assert(".a.".stripTextRight(".") == ".a");

  assert("a".stripTextRight(".") == "a");
  assert(".a".stripTextRight(".") == ".a");
  assert("a.".stripTextRight(".") == "a");
  assert(".a.".stripTextRight(".") == ".a");

  assert("a".stripTextRight(" ") == "a");
  assert(".a".stripTextRight(" ") == ".a");
  assert("a.".stripTextRight(" ") == "a.");
  assert(".a.".stripTextRight(" ") == ".a.");

  assert("a".stripTextRight(".", " ") == "a");
  assert(".a ".stripTextRight(".", " ") == ".a");
  assert(" a.".stripTextRight(".", " ") == " a");
  assert(" .a. ".stripTextRight(".", " ") == " .a.");
  assert(" .a. ".stripTextRight(" ", ".") == " .a");
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
