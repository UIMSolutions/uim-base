/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.datatypes.strings.strings;

import uim.phobos;
@safe:


// #region capitalize
string[] capitalize(string[] texts) {
  return texts
    .map!(text => std.string.capitalize(text))
    .array;
}

unittest {
  assert("hello".upper == "HELLO");
  assert(["hello", "ciao", "bonjour"].upper.equal(["HELLO", "CIAO", "BONJOUR"]));
}
// #endregion capitalize

// #region md5
string[] md5(string[] values) {
  return values.map!(value => md5(value)).array;
}

string md5(string value) {
  import std.digest.md;

  return toHexString(md5Of(value).dup);
}

unittest {
  assert(md5("abc") == "900150983CD24FB0D6963F7D28E17F72");
  assert("abc".md5 == "900150983CD24FB0D6963F7D28E17F72");
  assert("abc".md5 != "");

  assert(md5(["abc", "xyz"]) == [
      "900150983CD24FB0D6963F7D28E17F72", "D16FB36F0911F878998C136191AF705E"
    ]);
  assert(["abc", "xyz"].md5 == [
      "900150983CD24FB0D6963F7D28E17F72", "D16FB36F0911F878998C136191AF705E"
    ]);
  assert(["abc", "xyz"].md5 != ["", ""]);
}
// #endregion md5

// #region camelize
// Returns the input lower_case_delimited_string as a CamelCasedString.
string[] camelize(string[] texts, string delimiter = "_") {
  return texts.map!(text => text.camelize(delimiter)).array;
}

string camelize(string text, string delimiter = "_") {
  string cacheKey = __FUNCTION__ ~ delimiter;

  string result; // = _caching(cacheKey, text);
  if (result.isNull) {
    result = std.string.replace(humanize(text, delimiter), " ", "");
    // _caching(cacheKey, text, result);
  }

  return result;
}

unittest {
  assert("aa".camelize == "Aa");
  assert(["aa", "bb"].camelize == ["Aa", "Bb"]);
}
// #endregion camelize

// #region humanize
/**
     * Returns the input lower_case_delimited_string as 'A Human Readable String'.
     * (Underscores are replaced by spaces and capitalized following words.)
     */
string[] humanize(string[] texts, string delimiter = "_") {
  return texts.map!(text => humanize(text, delimiter)).array;
}

string humanize(string text, string delimiter = "_") {
  auto cacheKey = __FUNCTION__ ~ delimiter;

  string result; // = _caching(cacheKey, text);
  if (result.isEmpty) {
    string[] parts = std.string.split(std.string.replace(text, delimiter, " "), " ");
    result = parts.map!(part => std.string.capitalize(part)).join(" ");
    // _caching(cacheKey, text, result);
  }

  return result;
}

unittest {
  assert(["i_am_not_here", "where_are_you"].humanize == [
      "I Am Not Here", "Where Are You"
    ]);
  assert("hello_world_and_mars".humanize == "Hello World And Mars");
}
// #endregion humanize

// #region underscore
// Returns the input CamelCasedString as an underscored_string. Also replaces dashes with underscores
string[] underscore(string[] texts) {
  return texts.map!(text => text.underscore).array;
}

string underscore(string text) {
  return delimit(std.string.replace(text, "-", "_"), "_");
}

unittest {
  writeln(underscore("camel-cased-input-string") == "camel_cased_input_string");
  writeln(underscore("  camel-cased-input-string  ") == "  camel_cased_input_string  ");

  writeln(underscore("camel-cased-input-string") == "camel_cased_input_string");
  writeln(underscore("  camel-cased-input-string  ") == "  camel_cased_input_string  ");
}
// #endregion underscore

// Expects a CamelCasedInputString, and produces a lower_case_delimited_string
string[] delimit(string[] texts, string delimiter = "_") {
  return texts.map!(text => text.delimit(delimiter)).array;
}

string delimit(string text, string delimiter = "_") {
  // auto cacheKey = __FUNCTION__ ~ delimiter;
  string result; // = _caching(cacheKey, text);

  if (result.isEmpty) {
    /* auto regex = regex(r"/(?<=\\w)([A-Z])/");
      result = text.replaceAll(regex, delimiter ~ "\\1").lower; */
    // _caching(cacheKey, text, result);
    dchar lastChar;
    foreach (index, c; text) {
      result ~= std.uni.isUpper(c) && index > 0 && !std.uni.isWhite(lastChar)
        ? delimiter ~ c : "" ~ c;
      lastChar = c;
    }
  }
  return result.toLower;
}

unittest {
  writeln("delimit");
  writeln(delimit("CamelCasedInputString"));
  writeln(delimit("  CamelCasedInputString  x"));
  writeln(delimit("  CamelCasedInputString  x"));
  writeln(delimit("xX  CamelCasedInputString  xX"));
}

// Return myword in singular form.
string singularize(string pluralWord) {
  /*     if (hasKey(_cache["singularize"][pluralWord])) {
      return _cache["singularize"][pluralWord];
    }
 */
  /* auto irregularWords = _cache.get("irregular", null);
    if (!irregularWords.hasKey("singular")) {
      mywordList = _irregular.values;
      static.irregularWords.set("singular", "/(.*?(?:\\b|_))(" ~ mywordList.join("|") ~ ")my/i");

      myupperWordList = mywordList.capitalize;
      static.irregularWords.set("singularUpper", "/(.*?(?:\\b|[a-z]))("~myupperWordList.join("|""))
        .")my/";
    }

    if (
      preg_match(irregularWords["singular"], pluralWord, myregs) ||
      preg_match(irregularWords["singularUpper"], pluralWord, myregs)
      ) {
      mysuffix = array_search(myregs[2].lower, _irregular, true);
      mysuffix = mysuffix ? subString(mysuffix, 1) : "";
      // _cache["singularize"][pluralWord] = myregs[1] ~ subString(myregs[2], 0, 1) ~ mysuffix;

      return _cache["singularize"][pluralWord];
    }
    if (!_cache.hasKey("uninflected")) {
      _cache["uninflected"] = "/^(" ~ _uninflected.join("|") ~ ")my/i";
    }
    if (preg_match(_cache["uninflected"], pluralWord, myregs)) {
      _cache["pluralize"][pluralWord] = pluralWord;

      return pluralWord;
    }

    foreach (myrule, myreplacement; _singular) {
      if (preg_match(myrule, pluralWord)) {
        _cache["singularize"][pluralWord] = to!string(preg_replace(myrule, myreplacement, pluralWord));
        return _cache["singularize"][pluralWord];
      }
    }
    // _cache["singularize"][pluralWord] = pluralWord;

    return pluralWord; */
  return null;
}

// #region tableize
// Returns corresponding table name for given model myclassname. ("people" for the model class "Person").
string[] tableize(string[] classnames) {
  return classnames.map!(name => name.tableize).array;
}

string tableize(string classname) {
  string result; // = _caching(__FUNCTION__, myclassname);
  if (result.isEmpty) {
    result = classname.underscore.pluralize;
    // _caching(__FUNCTION__, myclassname, result);
  }
  return result;
}

unittest {
  // 
}
// #endregion tableize

// #region classify
// Returns uim model class name ("Person" for the database table "people".) for given database table.
string[] classify(string[] tableNames) {
  return tableNames.map!(name => name.classify).array;
}

string classify(string tableName) {
  string result; // = _caching(__FUNCTION__, mytableName);

  if (result.isEmpty) {
    // TODO result = tableName.singularize.camelize;
    // _caching(__FUNCTION__, mytableName, result);
  }
  return result;
}
// #endregion classify

// Return myword in plural form.
string pluralize(string singularWord) {
  /* auto pluralizeWords = _cache.get("pluralize", null);
  if (pluralizeWords.hasKey(singularWord)) { // Found in cache
    return pluralizeWords[singularWord];
  }

  auto irregularWords = _cache.get("irregular", null);
  if (irregularWords.isNull("pluralize")) {
    mywords = _irregular.keys;
    static.irregularWords["pluralize"] = "/(.*?(?:\\b|_))(" ~ join("|", mywords)~")my/i";

    myupperWords = array_map("ucfirst", mywords);
    static.irregularWords.set("upperPluralize", "/(.*?(?:\\b|[a-z]))(" ~ join("|", myupperWords) ~ ")my/");
  }
  if (
    preg_match(irregularWords["pluralize"], singularWord, myregs) ||
    preg_match(irregularWords["upperPluralize"], singularWord, myregs)
    ) {
    pluralizeWords[singularWord] = myregs[1] ~ subString(myregs[2], 0, 1)
      .subString(
        _irregular[strtolower(myregs[2])], 1);

    return pluralizeWords[singularWord];
  }
  if (!_cache.hasKey("uninflected")) {
    _cache.set("uninflected", "/^(" ~ _uninflected.join("|") ~ ")my/i");
  }
  if (preg_match(_cache["uninflected"], singularWord, myregs)) {
    pluralizeWords[singularWord] = singularWord;

    return singularWord;
  }
  foreach (_plural as myrule : myreplacement) {
    if (preg_match(myrule, singularWord)) {
      pluralizeWords[singularWord] = (string) preg_replace(myrule, myreplacement, singularWord);

      return pluralizeWords[singularWord];
    }
  }
  return singularWord; */
  return null;
}

// #region endsWith
bool allEndsWith(string[] values, string text) {
  if (text.length == 0 || values.length == 0) {
    return false;
  }

  return values.all!(value => endsWith(value, text));
}

bool anyEndsWith(string[] values, string text) {
  if (text.length == 0 || values.length == 0) {
    return false;
  }

  return values.any!(value => endsWith(value, text));
}

unittest { // bool anyEndsWith(string[] values, string text)
  assert(anyEndsWith(["hello", "world"], "ld") == true, "Test case 1 failed");
  assert(anyEndsWith(["hello", "world"], "lo") == true, "Test case 2 failed");
  assert(anyEndsWith(["hello", "world"], "z") == false, "Test case 3 failed");
  assert(anyEndsWith(["hello", "world"], "") == false, "Test case 4 failed");
  assert(anyEndsWith([], "ld") == false, "Test case 5 failed");
  assert(anyEndsWith(["hello", "world"], "world") == true, "Test case 6 failed");
  assert(anyEndsWith(["hello", "world"], "abc") == false, "Test case 7 failed");
}

unittest { // bool allEndsWith(string[] values, string text)
  assert(allEndsWith(["hello", "world"], "ld") == false, "Test case 1 failed");
  assert(allEndsWith(["hello", "world"], "lo") == false, "Test case 2 failed");
  assert(allEndsWith(["hello", "world"], "z") == false, "Test case 3 failed");
  assert(allEndsWith(["hello", "world"], "") == false, "Test case 4 failed");
  assert(allEndsWith([], "ld") == false, "Test case 5 failed");
  assert(allEndsWith(["world", "wild"], "ld") == true, "Test case 6 failed");
  assert(allEndsWith(["hello", "world"], "world") == false, "Test case 7 failed");
}
// #endregion endsWith

// #region startsWith
bool allStartsWith(string[] values, string text) {
  if (text.length == 0 || values.length == 0) {
    return false;
  }

  return values.all!(value => startsWith(value, text));
}

bool anyStartsWith(string[] values, string text) {
  if (text.length == 0 || values.length == 0) {
    return false;
  }

  return values.any!(value => startsWith(value, text));
}

unittest { // bool anyStartsWith(string[] values, string text)
  assert(anyStartsWith(["hello", "world"], "he") == true, "Test case 1 failed");
  assert(anyStartsWith(["hello", "world"], "wo") == true, "Test case 2 failed");
  assert(anyStartsWith(["hello", "world"], "z") == false, "Test case 3 failed");
  assert(anyStartsWith(["hello", "world"], "") == false, "Test case 4 failed");
  assert(anyStartsWith([], "he") == false, "Test case 5 failed");
  assert(anyStartsWith(["hello", "world"], "hello") == true, "Test case 6 failed");
  assert(anyStartsWith(["hello", "world"], "world") == true, "Test case 7 failed");
  writeln("All anyStartsWith tests passed!");
}

unittest { // bool allStartsWith(string[] values, string text)
  assert(allStartsWith(["hello", "world"], "he") == false, "Test case 1 failed");
  assert(allStartsWith(["hello", "world"], "wo") == false, "Test case 2 failed");
  assert(allStartsWith(["hello", "world"], "z") == false, "Test case 3 failed");
  assert(allStartsWith(["hello", "world"], "") == false, "Test case 4 failed");
  assert(allStartsWith([], "he") == false, "Test case 5 failed");
  assert(allStartsWith(["hello", "hi"], "h") == true, "Test case 6 failed");
  assert(!allStartsWith(["world", "wild"], "wi") == true, "Test case 7 failed");

  writeln("All allStartsWith tests passed!");
}
// #endregion startsWith
