/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.interfaces.keyandpath;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

interface IKeyAndPath {
  // #region paths
  string[][] paths();

  mixin(HasInterfaces!("Paths", "Path", "string[]"));

  bool hasPath(string[] path);
  // #endregion paths

  // #region keys
  string[] keys(SORTORDERS sortorder = NOSORT);

  mixin(HasInterfaces!("Keys", "Key", "string"));

  bool hasKey(string key);

  string correctKey(string[] path);

  string correctKey(string key);
  // #endregion keys

  // #region remove
  bool removePaths(string[][] paths);

  bool removePath(string[] path);

  bool removeKeys(string[] keys);

  bool removeKey(string key);

  void clear();
  // #endregion remove
}

