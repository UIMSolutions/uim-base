/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.paths.remove;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

interface IremoveMany(T) {
  // Removes the given paths from the collection.
  bool removeMany(string[][] paths);

  // Removes a specific path from the collection.
  bool remove(string[] path);
}
