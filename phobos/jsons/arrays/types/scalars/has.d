/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.arrays.types.scalars.has;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool hasOnlyScalar(Json[] jsons) {
  return jsons.all!(json => isScalar(json));
}

bool hasScalar(Json[] jsons) {
  return jsons.any!(json => isScalar(json));
}
