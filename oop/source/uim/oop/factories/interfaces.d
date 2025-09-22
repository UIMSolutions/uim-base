/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.factories.interfaces;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

interface IFactory(T){
  T[string] createMany(string[][] paths, Json[string] options = null);
  T create(string[] path, Json[string] options = null);

  T[string] createMany(string[] keys, Json[string] options = null);
  T create(string key, Json[string] options = null);

  // #region has
  // Checks if the collection contains all keys.
  bool hasAllPath(string[][] paths);
  bool hasAllKey(string[] keys);

  // Checks if the collection contains any of the given keys.
  bool hasAnyPath(string[][] paths);
  bool hasAnyKey(string[] keys);

  // Checks if the collection contains a specific key.
  bool hasPath(string[] path);  
  bool hasKey(string key);
  // #endregion has

  // #region change
  // Sets a specific item in the collection.
  bool setPath(string[] path, T delegate(Json[string] options = null) @safe createFunc);
  bool setKey(string key, T delegate(Json[string] options = null) @safe createFunc);

  // Updates a specific item in the collection.
  bool updatePath(string[] path, T delegate(Json[string] options = null) @safe createFunc);
  bool updateKey(string key, T delegate(Json[string] options = null) @safe createFunc);

  // Merges a specific item into the collection.
  bool mergePath(string[] path, T delegate(Json[string] options = null) @safe createFunc);
  bool mergeKey(string key, T delegate(Json[string] options = null) @safe createFunc);
  // #region change

  // #region remove
  // Removes all items from the collection.
  bool removeAll();   

  // Removes the given items from the collection.
  bool removePaths(string[][] paths);
  bool removeKeys(string[] keys);

  // Removes a specific item from the collection.
  bool removePath(string[] path);
  bool removeKey(string key);
  // #endregion remove
}
