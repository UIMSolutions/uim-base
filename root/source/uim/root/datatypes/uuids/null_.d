/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.uuids.null_;

import uim.root;

mixin(Version!("show_module"));

@safe:

/// Checks if the given UUID is a null UUID (all zeros).
bool isNullUUID(UUID uuid) {
  return uuid == UUID();
}
///
unittest {
  version (test_uim_root)
    writeln("Testing isNullUUID for UUID");
    
  assert(isNullUUID(UUID()));
  assert(!isNullUUID(randomUUID));
}

