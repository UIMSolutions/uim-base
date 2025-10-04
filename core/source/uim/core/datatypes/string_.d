/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.datatypes.string_;

import uim.core;
mixin(Version!("test_uim_core"));

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
// text - String value
// startPos - Required. Specifies where to start in the string. Starting with 0 (first letter)
// length  - Specifies the length of the returned string. Default is to the end of the string.
// A positive number - The length to be returned from the start parameter
// Negative number - The length to be returned from the end of the string
// If the length parameter is 0, NULL, or FALSE - it return an empty string
string subString(string text, int offset, int length = 0) {
  if (abs(offset) >= text.length) {
    return null;
  }

  int startPos = 0;
  int endPos = to!int(text.length);

  // If length is 0, return from offset to end
  if (offset > 0) {
    startPos = offset;
  } else {
    startPos = to!int(text.length) + offset;
  }

  endPos = length > 0
    ? startPos + length : endPos + length;

  startPos = max(0, startPos);
  endPos = min(text.length, endPos);
  if (startPos >= endPos) {
    return null; // If start position is greater than or equal to end position, return null
  }
  return text[startPos .. endPos];
}

unittest {
  // Basic positive offset, no length (should return from offset to end)
  assert(subString("This is a test", 4) == " is a test");
  // Negative offset, no length (should return from start to offset from end)
  assert(subString("This is a test", -4) == "test");
  // Positive offset, positive length
  assert(subString("0123456789", 4, 2) == "45");
  // Negative offset, positive length (should start at length-4, take 2 chars)
  assert(subString("0123456789", -4, 2) == "67");
  // Negative offset, negative length (should start at length-4, end at length-2)
  assert(subString("0123456789", -4, -2) == "67");
  // Offset out of bounds (too large)
  assert(subString("abc", 10) is null);
  // Offset out of bounds (too negative)
  assert(subString("abc", -10) is null);
  // Length zero (should return from offset to end)
  assert(subString("abcdef", 2, 0) == "cdef");
  // Length negative, end before start (should return null)
  assert(subString("abcdef", 4, -5) is null);
  // Length positive, end past string (should return from startPos to end)
  assert(subString("abcdef", 3, 10) == "def");
  // Offset at end of string (should return empty string)
  assert(subString("abcdef", 6) == "");
  // Offset at end of string, length positive (should return empty string)
  assert(subString("abcdef", 6, 2) == "");
  // Offset at end of string, length negative (should return null)
  assert(subString("abcdef", 6, -1) is null);
  // Empty string input
  assert(subString("", 0) is null);
} // #endregion substring

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
  // assert(countWords("This is a test")["this"] == 0);
  assert(countWords("this is a test")["this"] == 1);
  assert(countWords("this is a this")["this"] == 2);
}
// #endregion countWords

// #region repeatTxt
string repeatTxt(string text, size_t times, string separator = "") {
  if (times == 0) {
    return null;
  }

  return iota(0, times).map!(i => text).join(separator);
}

unittest {
  // Basic repetition, no separator
  assert(repeatTxt("bla", 2) == "blabla");
  // Basic repetition, with separator
  assert(repeatTxt("bla", 3, ",") == "bla,bla,bla");
  // Repetition with empty string
  assert(repeatTxt("", 3) == "");
  // Repetition with separator and empty string
  assert(repeatTxt("", 3, "-") == "--");
  // Repetition with times = 1
  assert(repeatTxt("abc", 1) == "abc");
  // Repetition with times = 0 should return null
  assert(repeatTxt("abc", 0) is null);
  // Repetition with separator longer than text
  assert(repeatTxt("x", 4, "123") == "x123x123x123x");
  // Repetition with unicode
  assert(repeatTxt("ü", 3, "|") == "ü|ü|ü");
}
// #endregion repeatTxt

// #region firstElement
/// Returns the first element of a string separated by a separator.
/// If the separator is not found, the whole string is returned.
/// If the string is empty, an empty string is returned.
string firstElement(string text, string separator = " ") {
  if (text.length == 0) {
    return text;
  }

  auto firstIndex = text.countUntil(separator);
  return firstIndex < 0
    ? text : text[0 .. firstIndex];
}

unittest {
  // Basic usage with default separator (space)
  assert(firstElement("hello world") == "hello");
  assert(firstElement("foo bar baz") == "foo");
  // Separator at the start
  assert(firstElement(" hello world") == "");
  // Separator at the end (should return everything before separator)
  assert(firstElement("hello ") == "hello");
  // No separator present (should return the whole string)
  assert(firstElement("helloworld") == "helloworld");
  // Empty string input
  assert(firstElement("") == "");
  // Custom separator
  assert(firstElement("a/b/c", "/") == "a");
  assert(firstElement("foo|bar|baz", "|") == "foo");
  // Separator not found with custom separator
  assert(firstElement("abc-def", "/") == "abc-def");
  // Multiple consecutive separators
  assert(firstElement("a..b.c", ".") == "a");
  assert(firstElement("..a.b", ".") == "");
  // Separator is a multi-character string
  assert(firstElement("abc--def--ghi", "--") == "abc");
  assert(firstElement("--abc--def", "--") == "");
  // Separator is a space, but no space present
  assert(firstElement("abc") == "abc");
  // Separator is a tab
  assert(firstElement("foo\tbar\tbaz", "\t") == "foo");
  // Separator is a comma
  assert(firstElement("x,y,z", ",") == "x");
  // Separator is at the end, custom separator
  assert(firstElement("abc/", "/") == "abc");
  // Separator is at the start, custom separator
  assert(firstElement("/abc", "/") == "");
}
// #endregion firstElement

// #region lastElement
/// Returns the last element of a string separated by a separator.
/// If the separator is not found, the whole string is returned.
/// If the string is empty, null is returned.
string lastElement(string text, string separator = " ") {
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
  // Basic usage with default separator (space)
  assert(lastElement("hello world") == "world");
  assert(lastElement("foo bar baz") == "baz");
  // Separator at the start (should return everything after the first separator)
  assert(lastElement(" hello world") == "world");
  // Separator at the end (should return empty string)
  assert(lastElement("hello ") == "");
  // No separator present (should return the whole string)
  assert(lastElement("helloworld") == "helloworld");
  // Empty string input (should return null)
  assert(lastElement("") is null);
  // Custom separator
  assert(lastElement("a/b/c", "/") == "c");
  assert(lastElement("foo|bar|baz", "|") == "baz");
  // Separator not found with custom separator
  assert(lastElement("abc-def", "/") == "abc-def");
  // Multiple consecutive separators
  assert(lastElement("a..b.c", ".") == "c");
  assert(lastElement("..a.b", ".") == "b");
  // Separator is a multi-character string
  assert(lastElement("abc--def--ghi", "--") == "ghi");
  assert(lastElement("--abc--def", "--") == "def");
  // Separator is a space, but no space present
  assert(lastElement("abc") == "abc");
  // Separator is a tab
  assert(lastElement("foo\tbar\tbaz", "\t") == "baz");
  // Separator is a comma
  assert(lastElement("x,y,z", ",") == "z");
  // Separator is at the end, custom separator
  assert(lastElement("abc/", "/") == "");
  // Separator is at the start, custom separator
  assert(lastElement("/abc", "/") == "abc");
}
// #endregion lastElement


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

// #region ifEmpty
/// Returns the first string if it is not empty, otherwise returns the second string. 
string ifEmpty(string check, string value) {
  return check.length > 0
    ? check : value;
}

unittest {
  // Returns check if not empty
  assert(ifEmpty("abc", "xyz") == "abc");
  assert(ifEmpty("0", "xyz") == "0");
  assert(ifEmpty(" ", "xyz") == " ");

  // Returns value if check is empty
  assert(ifEmpty("", "xyz") == "xyz");
  // Returns value if check is empty string, even if value is also empty
  assert(ifEmpty("", "") == "");
}
// #endregion ifEmpty

// #region mustache
string mustache(string text, Json[string] items) {
  items.byKeyValue.each!(item => text = text.mustache(item.key, item.value));
  return text;
}

string mustache(string text, Json map, string[] selectedKeys = null) {
  if (!map.isObject) {
    return text; // If items is not an object, return the original text
  }
  map.keys
    .filter!(key => map.hasKey(key))
    .filter!(key => selectedKeys.length == 0 || selectedKeys.hasValue(key))
    .each!(key => text = text.mustache(key, map[key]));
  return text;
}

string mustache(string text, string[string] items) {
  items.byKeyValue.each!(item => text = text.mustache(item.key, item.value));
  return text;
}

string mustache(string text, string[] keys, string[] values) {
  if (keys.length != values.length) {
    throw new Exception("Keys and values must have the same length.");
  }
  for (size_t i = 0; i < keys.length; i++) {
    text = text.mustache(keys[i], values[i]);
  }
  return text;
}

string mustache(string text, string key, Json value) {
  return std.string.replace(text, "{" ~ key ~ "}", value.toString);
}

string mustache(string text, string key, string value) {
  return std.string.replace(text, "{" ~ key ~ "}", value);
}

unittest {
  // Test mustache with string[string] items
  assert(mustache("Hello {name}!", ["name": "World"]) == "Hello World!");
  assert(mustache("A:{a}, B:{b}", ["a": "x", "b": "y"]) == "A:x, B:y");
  assert(mustache("Nothing to replace", ["foo": "bar"]) == "Nothing to replace");
  assert(mustache("{a}{b}{c}", ["a": "1", "b": "2", "c": "3"]) == "123");
  assert(mustache("{a}{b}{c}", ["a": "1", "b": "2"]) == "12{c}");

  // Test mustache with Json[string] items
  Json[string] jmap;
  jmap["x"] = Json("42");
  jmap["y"] = Json("abc");
  assert(mustache("X:{x}, Y:{y}", jmap) == "X:42, Y:abc");

  // Test mustache with string[] keys and values
  assert(mustache("A:{a}, B:{b}", ["a", "b"], ["foo", "bar"]) == "A:foo, B:bar");
  assertThrown!Exception(mustache("A:{a}, B:{b}", ["a"], ["foo", "bar"]));

  // Test mustache with string key/value
  assert(mustache("Hello {who}!", "who", "world") == "Hello world!");
  assert(mustache("{x}{y}", "x", "1") == "1{y}");

  // Test mustache with string key/Json value
  assert(mustache("Value: {val}", "val", Json(123)) == "Value: 123");
  assert(mustache("{foo}", "foo", Json("bar")) == "bar");

  // Test with missing placeholders
  assert(mustache("No placeholders", ["a": "b"]) == "No placeholders");
  assert(mustache("No {x}", "y", "z") == "No {x}");

  // Test with empty input
  assert(mustache("", ["a": "b"]) == "");
  assert(mustache("", "a", "b") == "");
  assert(mustache("", ["a"], ["b"]) == "");
}
// #endregion mustache

// #region doubleMustache
string doubleMustache(string text, Json[string] items, string[] selectedKeys = null) {
  if (selectedKeys.length > 0) {
    selectedKeys.filter!(key => key in items)
      .each!(key => text = text.doubleMustache(key, items[key]));
  } else {
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
