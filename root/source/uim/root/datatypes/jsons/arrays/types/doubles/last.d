/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.arrays.types.doubles.last;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

/** 
  * Returns the last JSON value of type `double` from the given JSON array.
  *
  * Params:
  *   jsons = The JSON array to search.
  *
  * Returns:
  *   The last JSON value of type `double`, or `Json(null)` if none found.
  */
Json lastDouble(Json[] jsons) {
  import uim.vibe.datatypes.jsons.arrays.types.doubles.filter;
  return jsons.filterDoubles.last;
}

