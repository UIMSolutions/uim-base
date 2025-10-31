/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// An interface for creating objects compatible with Configure.load()
interface IConfigEngine : IDirectory!Json {
  // #region path
  // #region has
  bool hasAllEntry(string[][] paths);
  bool hasAnyEntry(string[][] paths);

  bool hasEntry(string[] path);
  // #endregion has

  // #region set
  bool setAllEntry(string[][] paths, Json value);
  bool setAnyEntry(string[][] paths, Json value);

  bool setEntry(string[] path, Json value);
  // #endregion set

  // #region merge
  bool mergeAllEntries(string[][] paths, Json value);
  bool mergeAnyEntries(string[][] paths, Json value);

  bool mergeEntry(string[] path, Json value);
  // #endregion merge

  // #region update
  bool updateAllEntries(string[][] paths, Json value);
  bool updateAnyEntries(string[][] paths, Json value);

  bool updateEntry(string[] path, Json value);
  // #endregion update

  // #region remove
  bool removeAllEntries(string[][] paths);
  bool removeAnyEntries(string[][] paths);

  bool removeEntry(string[] path);
  // #endregion remove
  // #endregion paths

  // #region keys
  // #region has
  bool hasAllEntry(string[] keys);
  bool hasAnyEntry(string[] keys);

  bool hasEntry(string key);
  // #endregion has

  // #region set
  bool setAllEntry(Json[string] values);
  bool setAnyEntry(Json[string] values);

  bool setAllEntry(string[] keys, Json value);
  bool setAnyEntry(string[] keys, Json value);

  bool setEntry(string key, Json value);
  // #endregion set

  // #region merge
  bool mergeAllEntries(Json[string] values);
  bool mergeAnyEntries(Json[string] values);

  bool mergeAllEntries(string[] keys, Json value);
  bool mergeAnyEntries(string[] keys, Json value);

  bool mergeEntry(string key, Json value);
  // #endregion merge

  // #region update
  bool updateAllEntries(Json[string] values);
  bool updateAnyEntries(Json[string] values);

  bool updateAllEntries(string[] keys, Json value);
  bool updateAnyEntries(string[] keys, Json value);

  bool updateEntry(string key, Json value);
  // #endregion update

  // #region remove
  bool removeAllEntries(string[] keys);
  bool removeAnyEntries(string[] keys);

  bool removeEntry(string key);
  // #endregion remove
  // #endregion keys
}
