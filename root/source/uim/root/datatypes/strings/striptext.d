module uim.root.datatypes.strings.striptext;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

/**
  Converts dashes and spaces to underscores in the given text(s).
  
  Params:
      texts = The text(s) to convert.
  
  Returns:
      The converted text(s) with underscores.
  */
string[] stripText(string[] texts, string[] stripchars= null) {
  return texts
    .map!(text => stripText(text, stripchars))
    .array;
}

/**
  * Strips the specified characters from both ends of the given text.
  *
  * Params:
  *   text = The text to strip.
  *   stripchars = The characters to strip. If null or empty, whitespace is stripped.
  *
  * Returns:
  *   The stripped text.
  */
string stripText(string text, string[] stripchars = null) {
  if (text.length == 0) {
    return text;
  }

  if (stripchars.length == 0) {
    return text.strip;
  }

  foreach (c; stripchars) {
    text = text.strip(c);
  }

  return text;
}
