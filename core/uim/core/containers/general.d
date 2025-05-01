/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.containers.general;

mixin(Version!("test_uim_core"));

import uim.core;
@safe:

bool isSet(V)(V value) {
  return !(value is null);
}

bool isSet(V)(Nullable!V value) {
  return !value.isNull;
}

bool isSet(V)(V[] values) {
  return !values.empty;
}
///
unittest {
  // TODO 
}

bool isSet(V)(V[] values, size_t[] index) {
  if (index.length == 0) {
    return false;
  }

  foreach (i; index) {
    if (i >= values.length) {
      return false;
    }
  }
  return true;
}
