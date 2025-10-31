/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.engine;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DConfigEngine : UIMObject, IConfigEngine {
  mixin(ConfigEngineThis!());

  // #region path
  // #region has
  bool hasAllEntry(string[][] paths) {
    return paths.all!(path => hasEntry(path));
  }
  bool hasAnyEntry(string[][] paths) {
    return paths.any!(path => hasEntry(path));
  }

  bool hasEntry(string[] path) {
    return hasEntry(path.toKey(_separator));
  }
  // #endregion has

  // #region set
  bool setAllEntry(string[][] paths, Json value) {
    return paths.all!(path => setEntry(path, value));
  }
  bool setAnyEntry(string[][] paths, Json value) {
    return paths.any!(path => setEntry(path, value));
  }

  bool setEntry(string[] path, Json value) {
    return setEntry(path.toKey(_separator), value);
  }
  // #endregion set

  // #region merge
  bool mergeAllEntries(string[][] paths, Json value) {
    return paths.all!(path => mergeEntry(path, value));
  }
  bool mergeAnyEntries(string[][] paths, Json value) {
    return paths.any!(path => mergeEntry(path, value));
  }

  bool mergeEntry(string[] path, Json value) {
    return mergeEntry(path.toKey(_separator), value);
  }
  // #endregion merge

  // #region update
  bool updateAllEntries(string[][] paths, Json value) {
    return paths.all!(path => updateEntry(path, value));
  }
  bool updateAnyEntries(string[][] paths, Json value) {
    return paths.any!(path => updateEntry(path, value));
  }

  bool updateEntry(string[] path, Json value) {
    return updateEntry(path.toKey(_separator), value);
  }
  // #endregion update

  // #region remove
  bool removeAllEntries(string[][] paths) {
    return paths.all!(path => removeEntry(path));
  }
  bool removeAnyEntries(string[][] paths) {
    return paths.any!(path => removeEntry(path));
  }

  bool removeEntry(string[] path) {
    return removeEntry(path.toKey(_separator));
  }
  // #endregion remove
  // #endregion paths

  // #region keys
  // #region has
  bool hasAllEntry(string[] keys) {
    return keys.all!(key => hasEntry(key));
  }
  bool hasAnyEntry(string[] keys) {
    return keys.any!(key => hasEntry(key));
  }

  bool hasEntry(string key) {
    return hasEntry(key.toKey(_separator));
  }
  // #endregion has

  // #region set
  bool setAllEntry(Json[string] values) {
    return values.all!(kv => setEntry(kv.key, kv.value));
  }
  bool setAnyEntry(Json[string] values) {
    return values.any!(kv => setEntry(kv.key, kv.value));
  }

  bool setAllEntry(string[] keys, Json value) {
    return keys.all!(key => setEntry(key, value));
  }
  bool setAnyEntry(string[] keys, Json value) {
    return keys.any!(key => setEntry(key, value));
  }

  bool setEntry(string key, Json value) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion set

  // #region merge
  bool mergeAllEntries(Json[string] values) {
    return values.all!(kv => mergeEntry(kv.key, kv.value));
  }
  bool mergeAnyEntries(Json[string] values) {
    return values.any!(kv => mergeEntry(kv.key, kv.value));
  }

  bool mergeAllEntries(string[] keys, Json value) {
    return keys.all!(key => mergeEntry(key, value));
  }
  bool mergeAnyEntries(string[] keys, Json value) {
    return keys.any!(key => mergeEntry(key, value));
  } 

  bool mergeEntry(string key, Json value) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion merge

  // #region update
  bool updateAllEntries(Json[string] values) {
    return values.all!(kv => updateEntry(kv.key, kv.value));
  }
  bool updateAnyEntries(Json[string] values) {
    return values.any!(kv => updateEntry(kv.key, kv.value));
  }

  bool updateAllEntries(string[] keys, Json value) {
    return keys.all!(key => updateEntry(key, value));
  }
  bool updateAnyEntries(string[] keys, Json value) {
    return keys.any!(key => updateEntry(key, value));
  }

  bool updateEntry(string key, Json value) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion update

  // #region remove
  bool removeAllEntries(string[] keys) {
    return keys.all!(key => removeEntry(key));
  }
  bool removeAnyEntries(string[] keys) {
    return keys.any!(key => removeEntry(key));
  }

  bool removeEntry(string key) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion remove
  // #endregion keys
}
