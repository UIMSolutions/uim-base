/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.strings.strings;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:


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

// #region 



// #region classify
// Returns uim model class name ("Person" for the database table "people".) for given database table.
string[] classify(string[] tableNames) {
  return tableNames.map!(name => name.classify).array;
}

string classify(string tableName) {
  string result; 

  if (result.isEmpty) {
    // TODO result = tableName.singularize.camelize;
  }
  return result;
}
// #endregion classify

// #region startsWith


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
