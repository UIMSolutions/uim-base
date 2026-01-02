/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.scalars.last;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

/** 
  * Returns the last JSON scalar value from the given JSON array.
  *
  * Params:
  *   jsons = The JSON array to search.
  *
  * Returns:
  *   The last JSON scalar value, or `Json(null)` if none found.
  */
Json lastScalar(Json[] jsons) {
  import uim.root.datatypes.jsons.arrays.types.scalars.filter;
  return filterScalars(jsons).last;
}

