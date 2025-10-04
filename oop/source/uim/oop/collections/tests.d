/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.collections.tests;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

bool testCollection(T)(ICollection!T collection, string instanceName) if (is(T : UIMObject)) {
  assert(collection !is null, instanceName ~ " collection is null");
/*   assert(collection.empty, instanceName ~ " collection is not empty");
  assert(collection.length == 0, instanceName ~ " collection length is not zero");
  assert(collection.capacity == 0, instanceName ~ " collection capacity is not zero");
  assert(collection.first is null, instanceName ~ " collection first is not null");
  assert(collection.last is null, instanceName ~ " collection last is not null");
  assert(!collection.contains(null), instanceName ~ " collection contains null");
  assert(!collection.remove(null), instanceName ~ " collection removed null"); */
  
  return true;
}