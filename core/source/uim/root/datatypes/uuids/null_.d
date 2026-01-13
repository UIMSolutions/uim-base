/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.datatypes.uuids.null_;

import uim.core;

mixin(ShowModule!());

@safe:

/// Checks if the given UUID is a null UUID (all zeros).
bool isNullUUID(UUID uuid) {
  return uuid == UUID();
}
///
unittest {
  mixin(ShowTest!"Testing isNullUUID for UUID");
    
  assert(isNullUUID(UUID()));
  assert(!isNullUUID(randomUUID));
}

