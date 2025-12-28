module uim.root.datatypes.strings.pascalize;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

/**
  * Pascalizes the given array of texts by removing the specified delimiter and capitalizing the first letter of each word.
  *
  * Params:
  *   texts = An array of texts to pascalize.
  *   delimiter = The delimiter used to separate words in the input texts. Default is "_".
  *
  * Returns:
  *   An array of pascalized texts.
  */
string[] pascalize(string[] texts, string delimiter = "_") {
  return texts.map!(text => text.pascalize(delimiter)).array;
}
///
unittest {
  auto result = pascalize(["hello_world", "foo_bar"], "_");
  assert(result.length == 2);
  assert(result[0] == "helloWorld");
  assert(result[1] == "fooBar");
}

/**
  * Pascalizes the given text by removing the specified delimiter and capitalizing the first letter of each word.
  *
  * Params:
  *   text = The text to pascalize.
  *   delimiter = The delimiter used to separate words in the input text. Default is "_".
  *
  * Returns:
  *   The pascalized text.
  */
string pascalize(string text, string delimiter = "_") {
  // Handle empty string case
  if (text.length == 0) { 
    return "";
  }

  // 1. Split the string by common delimiters
  // Can be refined to handle multiple delimiters at once if needed
  auto words = text.split!(c => c == '_' || c == '-' || c == ' ');
  if (words.length == 0) {
    return "";
  }

  // 2. Start with the first word in lowercase
  string part1  = words[0].toLower();

  // 3. Capitalize subsequent words and append
  string part2 = words.length > 1 ? words[1 .. $].map!(word => word.capitalize()).join("") : "";

  return  part1 ~ part2;
}
///
unittest {
  assert(pascalize("hello_world", "_") == "helloWorld");
  assert(pascalize("foo-bar", "-") == "fooBar");
  assert(pascalize("multiple delimiters here", " ") == "multipleDelimitersHere");
}
