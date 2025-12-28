module uim.root.datatypes.strings.humanize;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

/**
  * Humanizes the given texts by replacing the specified delimiter with spaces and capitalizing each word.
  *
  * Params:
  *   texts = An array of strings to be humanized.
  *   delimiter = The delimiter used in the input strings (default is "_").
  *
  * Returns:
  *   An array of humanized strings.
  */
string[] humanize(string[] texts, string delimiter = "_") {
  return texts.map!(text => humanize(text, delimiter)).array;
}
///
unittest {
  auto result = humanize(["hello_world", "foo_bar"], "_");
  assert(result.length == 2);
  assert(result[0] == "Hello World");
  assert(result[1] == "Foo Bar");
}

/**
  * Humanizes the given text by replacing the specified delimiter with spaces and capitalizing each word.
  *
  * Params:
  *   text = The string to be humanized.
  *   delimiter = The delimiter used in the input string (default is "_").
  *
  * Returns:
  *   The humanized string.
  */
string humanize(string text, string delimiter = "_") {

  string result = text; 
  if (result.isEmpty) {
    string[] parts = std.string.split(text.replace(delimiter, " "), " ");
    result = parts.map!(part => std.string.capitalize(part)).join(" ");
  }

  return result;
}
///
unittest {
  assert(humanize("hello_world", "_") == "Hello World");
  assert(humanize("foo_bar_baz", "_") == "Foo Bar Baz");
}