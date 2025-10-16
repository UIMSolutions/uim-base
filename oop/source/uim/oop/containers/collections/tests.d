/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directorys.tests;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

bool testDirectory(T)(IDirectory!T directory, string instanceName) if (is(T : UIMObject)) {
  assert(directory !is null, instanceName ~ " directory is null");
/*   assert(directory.empty, instanceName ~ " directory is not empty");
  assert(directory.length == 0, instanceName ~ " directory length is not zero");
  assert(directory.capacity == 0, instanceName ~ " directory capacity is not zero");
  assert(directory.first is null, instanceName ~ " directory first is not null");
  assert(directory.last is null, instanceName ~ " directory last is not null");
  assert(!directory.contains(null), instanceName ~ " directory contains null");
  assert(!directory.remove(null), instanceName ~ " directory removed null"); */
  
  return true;
}