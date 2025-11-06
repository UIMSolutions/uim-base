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

  // #region keys
  string[] keys() {
    // TODO : Implement in subclasses
    return null;
  }
  // #endregion keys

  // #region values
  abstract Json[] values() {
    return keys.map!(key => value(key)).array;
  }

  Json[] values(string[][] paths) {
    return paths.map!(path => value(path)).array;
  }

  Json[] values(string[] keys) {
    return keys.map!(key => value(key)).array;
  }

  Json value(string[] path) {
    return value(path.toKey(_separator));
  }

  abstract Json value(string key);
  // #endregion values

  bool isEmpty() {
    return size == 0;
  }

  // #region size
  size_t size() {
    // TODO : Implement in subclasses
    return 0;
  }
  // #endregion size

  // #region hasAllValue
  bool hasAllValue(Json[] values) {
    return values.all!(value => hasValue(value));
  }
  // #endregion hasAllValue

  bool hasAnyValue(Json[] values) {
    return values.any!(value => hasValue(value));
  }

  bool hasValue(Json value) {
    return false;
  }
  // #endregion values

  string pathSeparator() {
    return _separator;
  }

  bool pathSeparator(string separator) {
    _separator = separator;
    return true;
  }

  // #region path
  // #region has
  bool hasAllPath(string[][] paths) {
    return paths.all!(path => hasKey(path));
  }

  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasKey(path));
  }

  bool hasPath(string[] path) {
    return hasKey(path.toKey(_separator));
  }
  // #endregion has

  // #region set
  bool setAllPath(string[][] paths, Json value) {
    return paths.all!(path => setKey(path, value));
  }

  bool setAnyPath(string[][] paths, Json value) {
    return paths.any!(path => setKey(path, value));
  }

  bool setPath(string[] path, Json value) {
    return setKey(path.toKey(_separator), value);
  }
  // #endregion set

  // #region merge
  bool mergeAllPath(string[][] paths, Json value) {
    return paths.all!(path => mergeKey(path, value));
  }

  bool mergeAnyPath(string[][] paths, Json value) {
    return paths.any!(path => mergeKey(path, value));
  }

  bool mergePath(string[] path, Json value) {
    return mergeKey(path.toKey(_separator), value);
  }
  // #endregion merge

  // #region update
  bool updateAllPath(string[][] paths, Json value) {
    return paths.all!(path => updateKey(path, value));
  }

  bool updateAnyPath(string[][] paths, Json value) {
    return paths.any!(path => updateKey(path, value));
  }

  bool updatePath(string[] path, Json value) {
    return updateKey(path.toKey(_separator), value);
  }
  // #endregion update

  // #region remove
  bool removeAllPath(string[][] paths) {
    return paths.all!(path => removeKey(path));
  }

  bool removeAnyPath(string[][] paths) {
    return paths.any!(path => removeKey(path));
  }

  bool removePath(string[] path) {
    return removeKey(path.toKey(_separator));
  }
  // #endregion remove
  // #endregion paths

  // #region keys
  // #region has
  bool hasAllKey(string[] keys) {
    return keys.all!(key => hasKey(key));
  }

  bool hasAnyKey(string[] keys) {
    return keys.any!(key => hasKey(key));
  }

  bool hasKey(string key) {
    return hasKey(key.toKey(_separator));
  }
  // #endregion has

  // #region set
  bool setAllKey(Json[string] values) {
    return values.all!(kv => setKey(kv.key, kv.value));
  }

  bool setAnyKey(Json[string] values) {
    return values.any!(kv => setKey(kv.key, kv.value));
  }

  bool setAllKey(string[] keys, Json value) {
    return keys.all!(key => setKey(key, value));
  }

  bool setAnyKey(string[] keys, Json value) {
    return keys.any!(key => setKey(key, value));
  }

  bool setKey(string key, Json value) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion set

  // #region merge
  bool mergeAllKey(Json[string] values) {
    return values.all!(kv => mergeKey(kv.key, kv.value));
  }

  bool mergeAnyKey(Json[string] values) {
    return values.any!(kv => mergeKey(kv.key, kv.value));
  }

  bool mergeAllKey(string[] keys, Json value) {
    return keys.all!(key => mergeKey(key, value));
  }

  bool mergeAnyKey(string[] keys, Json value) {
    return keys.any!(key => mergeKey(key, value));
  }

  bool mergeKey(string key, Json value) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion merge

  // #region update
  bool updateAllKey(Json[string] values) {
    return values.all!(kv => updateKey(kv.key, kv.value));
  }

  bool updateAnyKey(Json[string] values) {
    return values.any!(kv => updateKey(kv.key, kv.value));
  }

  bool updateAllKey(string[] keys, Json value) {
    return keys.all!(key => updateKey(key, value));
  }

  bool updateAnyKey(string[] keys, Json value) {
    return keys.any!(key => updateKey(key, value));
  }

  bool updateKey(string key, Json value) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion update

  // #region remove
  bool removeAllKey(string[] keys) {
    return keys.all!(key => removeKey(key));
  }

  bool removeAnyKey(string[] keys) {
    return keys.any!(key => removeKey(key));
  }

  bool removeKey(string key) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion remove
  // #endregion keys

  bool removeAllValue(Json[] values) {
    return values.all!(value => removeValue(value));
  }

  bool removeAnyValue(Json[] values) {
    return values.any!(value => removeValue(value));
  }

  bool removeValue(Json value) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }

  bool clear() {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
}
