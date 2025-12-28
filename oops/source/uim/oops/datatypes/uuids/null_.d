/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oops.datatypes.uuids.null_;

import uim.oops;

mixin(Version!("test_uim_root"));

@safe:

/// Checks if the given UUID is a null UUID (all zeros).
bool isNullUUID(UUID uuid) {
  return uuid == UUID();
}
///
unittest {
  assert(isNullUUID(UUID()));
  assert(!isNullUUID(randomUUID));
}

