/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.datatypes.string_;

mixin(Version!("test_uim_core"));

import uim.core;
@safe:


string toJSONString(T)(T[string] values, bool sorted = NOTSORTED) {
  string result = "{" ~ MapHelper.sortedKeys(values)
    .map!(key => `"%s": %s`.format(key, values[key]))
    .join(",") ~ "}";

  return result;
}

unittest {
  // assert(["a": 1, "b": 2].toJSONString(SORTED) == `{"a": 1,"b": 2}`);
}
// #region fill
/// create a string with defined length and content
string fill(size_t width, string fillText = "0") {
  if (width == 0 || fillText.length == 0) {
    return null;
  }

  string filledText;
  while (filledText.length < width) {
    filledText ~= fillText;
  }
  filledText.length = width; // cut result to length
  return filledText;
}

unittest {
  assert(fill(10, "0").length == 10);
  assert(fill(10, "0") == "0000000000");
  assert(fill(10, "TXT") == "TXTTXTTXTT");
}
// #endregion fill

// #region bind
string bind(string source, string[string] replaceMap, string placeHolder = "{{%s}}") {
  import std.string;

  string updatedText = source;
  replaceMap.byKeyValue
    .each!(kv => updatedText = std.string.replace(updatedText, placeHolder.format(kv.key), kv
        .value));

  return updatedText;
}

unittest {
  writeln("Testing bind()");

  assert("{{abc}}".bind(["abc": "xyz"]) == "xyz");
  assert("0{{abc}}0".bind(["abc": "xyz"]) == "0xyz0");
}
// #endregion bind



string toString(string[] values) {
  return "%s".format(values);
}

string quotes(string text, string leftAndRight) {
  return leftAndRight ~ text ~ leftAndRight;
}

string quotes(string text, string left, string right) {
  return left ~ text ~ right;
}

// TODO
/* 
string indent(in string text, size_t indent = 2) {
  if (indent == 0) {
    return text;
  }

  return fill(indent, " ") ~ text;
}

unittest {
  writeln("Testing indent()");

  assert(indent("Hallo").length == 7);
  assert(indent("Hallo") == "  Hallo");
  assert(indent("Hallo", 3).length == 8);
  assert(indent("Hallo", 3) == "   Hallo");
}

size_t[] indexOfAll(string text, string searchTxt) {
  if (text.indexOf(searchTxt) == -1)
    return [];

  size_t[] results;
  size_t currentPos = 0;
  while ((currentPos < text.length) && (currentPos >= 0)) {
    currentPos = text.indexOf(searchTxt, currentPos);
    if ((currentPos < text.length) && (currentPos >= 0)) {
      results ~= currentPos;
      currentPos++;
    }

  }
  return results;
}

*/ 

// #region substring
// subString() - returns a part of a string.
// aText - String value
// startPos - Required. Specifies where to start in the string. Starting with 0 (first letter)
// -- A positive number - Start at a specified position in the string
// -- A negative number - Start at a specified position from the end of the string
// -- 0 - Start at the first character in string
string subString(string aText, long startPos) {
  if (startPos == 0) {
    return aText;
  }

  return startPos > 0
    ? (startPos >= aText.length ? aText : aText[startPos .. $]) : (
      -startPos >= aText.length ? aText : aText[0 .. $ + startPos]);
}

// same like subString(), with additional parameter length
// length  - Specifies the length of the returned string. Default is to the end of the string.
// A positive number - The length to be returned from the start parameter
// Negative number - The length to be returned from the end of the string
// If the length parameter is 0, NULL, or FALSE - it return an empty string
string subString(string aText, size_t startPos, long aLength) {
  auto myText = subString(aText, startPos);
  return aLength > 0
    ? (myText.length >= aLength ? myText[0 .. aLength] : myText) : (
      myText.length >= -aLength ? myText[$ + aLength .. $] : myText);
}

unittest {
  version(test_uim_core) writeln("Testing subString()");
  assert("This is a test".subString(4) == " is a test");
  assert("This is a test".subString(-4) == "This is a ");

  assert("0123456789".subString(4, 2) == "45");
  assert("0123456789".subString(-4, 2) == "01");
  assert("0123456789".subString(-4, -2) == "45");
}
// #endregion substring

// #region capitalizeWords
string capitalizeWords(string aText, string separator = " ") {
  return capitalize(std.string.split(aText, separator)).join(separator);
}

unittest {
  // writeln("Testing capitalizeWords()");
  assert("this is a test".capitalizeWords == "This Is A Test");
  assert("this  is  a  test".capitalizeWords == "This  Is  A  Test");
}
// #endregion capitalizeWords

// #region countWords
size_t[string] countWords(string selectText, bool isCaseSensitive = true) {
  size_t[string] results;

  auto selectTexts = std.string.split(selectText, " ");
  if (!isCaseSensitive) {
    selectTexts = selectTexts.lower;
  }
  selectTexts
    .each!(word => results[word] = word in results ? results[word] + 1 : 1);

  return results;
}

size_t[string] countWords(string[] selectTexts, bool isCaseSensitive = true) {
  size_t[string] results;

  if (!isCaseSensitive) {
    selectTexts = selectTexts.lower;
  }
  selectTexts
    .each!(word => results[word] = word in results ? results[word] + 1 : 1);

  return results;
}

unittest {
  writeln("Testing countWords()");

  // assert(countWords("This is a test")["this"] == 0);
  assert(countWords("this is a test")["this"] == 1);
  assert(countWords("this is a this")["this"] == 2);
}
// #endregion countWords

string repeatTxt(string text, size_t times) {
  string result;
  for (auto i = 0; i < times; i++) {
    result ~= text;
  }
  return result;
}

unittest {
  writeln("Testing repeat()");

  assert(repeatTxt("bla", 0) is null);
  assert(repeatTxt("bla", 2) == "blabla");
}

string firstElement(string text, string separator = ".") {
  if (text.length == 0) {
    return text;
  }

  auto firstIndex = text.countUntil(separator);
  return firstIndex < 0
    ? text : text[0 .. firstIndex];
}

unittest {
  writeln("Testing firstElement()");

  assert("a/b/c".firstElement("/") == "a");
  assert("a.b.c".firstElement(".") == "a");
}

string lastElement(string text, string separator = ".") {
  if (text.length == 0) {
    return null;
  }

  auto lastIndex = text.retro.countUntil(separator);
  if (lastIndex < 0) {
    return text;
  }

  return text[($ - lastIndex) .. $];
}

unittest {
  writeln("Testing lastElement()");

  assert("a/b/c".lastElement("/") == "c");
  assert("a.b.c".lastElement(".") == "c");
}

// #region toPath
string toPath(string[] pathItems, string separator = ".") {
  return pathItems.stripText([" ", separator, " "])
    .filter!(item => item.length > 0)
    .join(separator);
}

unittest {
  assert(toPath(["a", "b", "c"]) == "a.b.c");
  assert(toPath(["a ", ".b", "c."]) == "a.b.c");
  assert(toPath(["a ", "", ".b", "c."]) == "a.b.c");

  assert(["a", "b", "c"].toPath("/") == "a/b/c");
  assert(["a ", "/b", "c/"].toPath("/") == "a/b/c");
  assert(["a ", "", "/b", "c/"].toPath("/") == "a/b/c");
}
// #region toPath





string[] split(string text, string splitText = " ", int limit) {
  auto splits = std.string.split(text, splitText);
  if (limit > 0 && limit < splits.length) {
    return splits[0 .. limit] ~ splits[limit .. $].join(splitText);
  }
  if (limit < 0 && limit > -splits.length) {
    return splits[0 .. -limit].join(splitText) ~ splits[-limit .. $];
  }
  return splits;
}

unittest {
  // TODO create test
}

// TODO
string[] split(string[] texts, string splitText = " ", int limit = 0) {
  auto splitTexts = texts
    .map!(text => split(text, splitText, limit)).array;
  return join(splitTexts);
}

///
unittest {
  writeln("Testing ifNull()");

  string a = null;
  assert(isNull(a));
  assert(a.isNull);

  a = "";
  assert(!isNull(a));
  assert(!a.isNull);

  a = "xyz";
  assert(!isNull(a));
  assert(!a.isNull);
  assert(!"xyz".isNull);
}

string ifEmpty(string check, string value) {
  if (value.length > 0) {
    return check;
  }
  return value;
}

// #region mustache
string mustache(string text, Json[string] items) {
  items.byKeyValue.each!(item => text = text.mustache(item.key, item.value));
  return text;
}

string mustache(string text, string[string] items) {
  items.byKeyValue.each!(item => text = text.mustache(item.key, item.value));
  return text;
}

string mustache(string text, string key, Json value) {
  return std.string.replace(text, "{" ~ key ~ "}", value.toString);
}

string mustache(string text, string key, string value) {
  return std.string.replace(text, "{" ~ key ~ "}", value);
}

unittest {
  assert("A:{a}, B:{b}".mustache(["a": "x", "b": "y"]) == "A:x, B:y");
  assert("A:{a}, B:{b}".mustache(["a": "a", "b": "b"]) != "A:x, B:y");
}
// #endregion mustache

// #region doubleMustache
string doubleMustache(string text, Json[string] items, string[] selectedKeys = null) {
  if (selectedKeys.length > 0) {
    selectedKeys.filter!(key => key in items)
      .each!(key => text = text.doubleMustache(key, items[key]));
  } 
  else {
    items.byKeyValue.each!(item => text = text.doubleMustache(item.key, item.value));
  }
  return text;
}

string doubleMustache(string text, string[string] items) {
  items.byKeyValue.each!(item => text = text.doubleMustache(item.key, item.value));
  return text;
}

string doubleMustache(string text, string key, Json value) {
  return std.string.replace(text, "{" ~ key ~ "}", value.toString);
}

string doubleMustache(string text, string key, string value) {
  return std.string.replace(text, "{{" ~ key ~ "}}", value);
}

unittest {
  assert("A:{{a}}, B:{{b}}".doubleMustache(["a": "x", "b": "y"]) == "A:x, B:y");
  assert("A:{{a}}, B:{{b}}".doubleMustache(["a": "a", "b": "b"]) != "A:x, B:y");

  string text = "A:{{a}}, B:{{b}}";
  assert(text.doubleMustache(["a": "x", "b": "y"]) == "A:x, B:y");
  assert(text == "A:{{a}}, B:{{b}}");
}
// #endregion doubleMustache

string match(K)(K key, string[K] matchValues, string defaultValue = null) {
  return key in matchValues
    ? matchValues[key] : defaultValue;
}

unittest {
  // TODO: Add Tests
}



/**
     * Returns the input CamelCasedString as an dashed-string.
     *
     * Also replaces underscores with dashes
     * Params:
     * string text The string to dasherize.
     */
/* static string dasherize(string stringToDasherize) {
    return delimit(stringToDasherize.replace("_", "-"), "-");
  } */



/**
     * Returns camelBacked version of an underscored string.
     * returns string in variable form
     */
string variable(string stringToConvert) {
  string result; // = // _caching(__FUNCTION__, stringToConvert);
  if (result.isEmpty) {
    string camelized = stringToConvert.underscore.camelize;
    string replaced = subString(camelized, 0, 1).toLower;
    result = replaced ~ subString(camelized, 1);
    // _caching(__FUNCTION__, stringToConvert, result);
  }
  return result;
}



// Cache inflected values, and return if already available
STRINGAA[string] _cache;
string _caching(string inflectionType, string originalValue, string inflectedValue = null) {
  originalValue = "_" ~ originalValue;
  inflectionType = "_" ~ inflectionType;
  if (!inflectedValue.isEmpty) {
    if (inflectionType !in _cache) {
      _cache[inflectionType] = null;
    }
    _cache[inflectionType][originalValue] = inflectedValue;
    return inflectedValue;
  }

  return inflectionType in _cache && originalValue in _cache[inflectionType]
    ? _cache[inflectionType][originalValue] : null;
}

bool isBoolean(string value) {
  return ["yes", "no", "true", "false", "0", "1", "on", "off"].hasValue(value.toLower);
}
// #endregion longestText

// #region longestText
protected string shortestText(string[] texts) {
  if (texts.isEmpty) {
    return null;
  }

  if (texts.length == 1) {
    return texts[0];
  }

  return texts.sort!("a.length < b.length")[0];
}

// #region longestText
protected string longestText(string[] texts) {
  if (texts.isEmpty) {
    return null;
  }

  if (texts.length == 1) {
    return texts[0];
  }

  return texts.sort!("a.length > b.length")[0];
}
unittest {
  // TODO
}
// #endregion longestText

// #region replace
string replace(string origin, string[] selects, string newTxt) {
  selects.each!(select => origin = std.string.replace(origin, select, newTxt));
  return origin;
}
unittest {
  // TODO
}
// #endregion replace

