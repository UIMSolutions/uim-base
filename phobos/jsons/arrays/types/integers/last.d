/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.integers.last;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json lastInteger(Json[] jsons) {
  import uim.root.datatypes.jsons.arrays.types.integers.filter;
  return jsons.filterIntegers.last;
}

  