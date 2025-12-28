/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.phobos.datatypes.strings.capitalize;

import uim.phobos;

mixin(Version!("test_uim_phobos"));

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
