module uim.phobos.strings.strings;

import uim.phobos;
@safe:

// #region lower
string lower(string text) {
  return text.toLower;
}

string[] lower(string[] texts) {
  return texts
    .map!(text => text.toLower)
    .array;
}

unittest {
  assert("A".lower == "a");
  assert(["A", "B", "C"].lower.equal(["a", "b", "c"]));
}
// #endregion lower

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