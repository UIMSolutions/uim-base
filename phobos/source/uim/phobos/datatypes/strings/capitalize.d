module uim.phobos.datatypes.strings.capitalize;

import uim.phobos;

@safe:

/** 
  * Capitalizes the first character of each text in the given array of texts.
  *
  * Params:
  *   texts = The texts to capitalize.
  *
  * Returns:
  *   An array of texts with the first character capitalized.
  */
string[] capitalize(string[] texts) {
  return texts
    .map!(text => std.string.capitalize(text))
    .array;
}
