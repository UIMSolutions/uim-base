/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.factories.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IFactory(V = IObject) : IHasKeys!(string, V), IHasPaths!(string, V), IRemoveKeys!(string, V), IRemovePaths!(string, V), IObject {
  V[string] createMany(string[][] paths, Json[string] options = null);
  V create(string[] path, Json[string] options = null);

  V[string] createMany(string[] keys, Json[string] options = null);
  V create(string key, Json[string] options = null);

  // #region change
  // Sets a specific item in the collection.
  bool setPath(string[] path, V delegate(Json[string] options = null) @safe createFunc);
  bool setKey(string key, V delegate(Json[string] options = null) @safe createFunc);

  // Updates a specific item in the collection.
  bool updatePath(string[] path, V delegate(Json[string] options = null) @safe createFunc);
  bool updateKey(string key, V delegate(Json[string] options = null) @safe createFunc);

  // Merges a specific item into the collection.
  bool mergePath(string[] path, V delegate(Json[string] options = null) @safe createFunc);
  bool mergeKey(string key, V delegate(Json[string] options = null) @safe createFunc);
  // #region change
}
