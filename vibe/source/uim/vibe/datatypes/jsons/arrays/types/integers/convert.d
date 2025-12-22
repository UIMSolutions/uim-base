/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.integers.convert;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/** 
  * Converts the given array of Jsons to an array of integers using the provided conversion function.
  *
  * Params:
  *   jsons = The array of Json objects to convert.
  *   convertFunc = A delegate function that takes a Json object and returns an integer.
  *
  * Returns:
  *   An array of integers resulting from the conversion.
  */
int[] toIntegers(Json[] jsons, int delegate(Json json) @safe convertFunc) {
  return jsons.map!(json => convertFunc(json)).array;
}

/** 
  * Converts the given array of Jsons to an array of integers by filtering based on the provided indices.
  *
  * Params:
  *   jsons = The array of Json objects to convert.
  *   indices = The indices of the Json array to consider for conversion.
  *
  * Returns:
  *   An array of integers resulting from the conversion of the filtered Jsons.
  */
int[] toIntegers(Json[] jsons, size_t[] indices) {
  import uim.vibe.datatypes.jsons.arrays.types.integers.filter;
  return jsons.filterIntegers(indices).toIntegers;
}

/** 
  * Converts the given array of Jsons to an array of integers by filtering for integer values.
  *
  * Params:
  *   jsons = The array of Json objects to convert.
  *
  * Returns:
  *   An array of integers resulting from the conversion of the filtered Jsons.
  */
int[] toIntegers(Json[] jsons) {
  import uim.vibe.datatypes.jsons.arrays.types.integers.filter;
  return jsons.filterIntegers.toIntegers;
}
///
unittest {
  import uim.vibe.datatypes.jsons.json;
  import uim.vibe.datatypes.jsons.arrays.types.integers.convert : toIntegers;

  Json[] jsons = [Json(1), Json(2.5), Json(3), Json("4"), Json(5)];

  // Test conversion with delegate function
  int[] result1 = toIntegers(jsons, (Json json) @safe => json.isInt ? json.get!int : 0);
  assert(result1 == [1, 0, 3, 0, 5]);

  // Test conversion with indices
  int[] result2 = toIntegers(jsons, [0, 2, 4]);
  assert(result2 == [1, 3, 5]);

  // Test conversion without any filters
  int[] result3 = toIntegers(jsons);
  assert(result3 == [1, 3, 5]);
}
