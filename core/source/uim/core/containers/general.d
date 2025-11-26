/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.core.containers.general;

import uim.core;

mixin(Version!("test_uim_core"));
@safe:

// #region isSet
// Checks whether value is set (not null, not empty, etc.)
bool isSet(V)(V value) {
  return !(value is null);
}
/// 
unittest {
  assert(isSet(5));
  assert(!isSet(cast(int) null));
  assert(isSet("Hello"));
  assert(!isSet(""));
} 

// Checks whether Nullable value is set (not null)
bool isSet(V)(Nullable!V value) {
  return !value.isNull;
}
/// 
unittest {
  Nullable!int a = 5;
  Nullable!int b;
  assert(isSet(a));
  assert(!isSet(b));
} 

// Checks whether array values are set (not empty)
bool isSet(V)(V[] values) {
  return !values.empty;
}
/// 
unittest {
  assert(isSet([1, 2, 3]));
  assert(!isSet([]));
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
/// 
unittest {
  assert(isSet([1, 2, 3], [0, 1]));
  assert(!isSet([1, 2, 3], [0, 3]));
  assert(!isSet([1, 2, 3], []));
} 
// #endregion isSet
