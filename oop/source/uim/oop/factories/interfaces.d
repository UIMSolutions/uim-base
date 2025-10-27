/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.factories.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IFactory(K = string, V = UIMObject) : IHasKeys!K, IHasPaths!K, IRemoveKeys!K, IRemovePaths!K, IObject {
  V[K] createMany(K[][] paths, Json[string] options = null);
  V create(K[] path, Json[string] options = null);

  V[K] createMany(K[] keys, Json[string] options = null);
  V create(K key, Json[string] options = null);

  // #region change
  // Sets a specific item in the collection.
  bool setPath(K[] path, V delegate(Json[string] options = null) @safe createFunc);
  bool setKey(K key, V delegate(Json[string] options = null) @safe createFunc);

  // Updates a specific item in the collection.
  bool updatePath(K[] path, V delegate(Json[string] options = null) @safe createFunc);
  bool updateKey(K key, V delegate(Json[string] options = null) @safe createFunc);

  // Merges a specific item into the collection.
  bool mergePath(K[] path, V delegate(Json[string] options = null) @safe createFunc);
  bool mergeKey(K key, V delegate(Json[string] options = null) @safe createFunc);
  // #region change
}
