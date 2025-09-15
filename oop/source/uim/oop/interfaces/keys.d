/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.keys;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

interface IKeys {
  string[] keys(SORTORDERS sortorder = NOSORT);

  bool hasAllKeys(string[] keys);
  bool hasAnyKeys(string[] keys);
  bool hasKey(string key);

  string pathToKey(string[] path);

  bool removePaths(string[][] paths);
  bool removePath(string[] path);

  bool clear();
}

