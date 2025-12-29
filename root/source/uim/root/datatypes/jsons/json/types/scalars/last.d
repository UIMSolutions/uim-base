/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.scalars.last;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json lastScalar(Json[] jsons) {
  return jsons.filterScalars.last;
}

