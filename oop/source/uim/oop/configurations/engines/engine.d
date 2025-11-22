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

  // #region IObject
  // Get the name of the object.
  override string name() {
    return super.name;
  }

  // Get or set the name of the object.
  override void name(string newName) {
    super.name(newName);
  }

  // Compares two IObject instances for equality based on their names.
  override bool isEqual(IObject other) {
    if (!super.isEqual(other)) {
      return false;
    }

    if (this is other) {
      return true;
    }
    if (this.classinfo !is other.classinfo) {
      return false;
    }
    if (other is null) {
      return false;
    }
    if (this.name is null || other.name is null) {
      return false;
    }

    return this.name == other.name;
    // TODO: Consider adding more properties for comparison if needed.
  }

  // Returns a string representation comparing two IObject instances.
  override string toString() {
    return "DValidator: " ~ this.name;
  }

  // Creates a clone of the current object.
  override IObject clone() {
    auto engine = new DConfigEngine;
    engine.name(this.name);
    return engine;
  }
  // #endregion IObject

  // #region paths
  Json[string] entries() {
    return null;
  }

  void entries(Json[string] entries) {
    // TODO : Implement in subclasses
  }
  // #endregion entries

  // #region keys
  string[] keys() {
    // TODO : Implement in subclasses
    return null;
  }
  // #endregion keys

  // #region isEmpty
  bool isEmpty() {
    return size == 0;
  }
  // #endregion isEmpty

  // #region size
  size_t size() {
    // TODO : Implement in subclasses
    return 0;
  }
  // #endregion size

  // #region has
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
  // #endregion has
  // #endregion values

  // #region pathSeparator
  protected string _separator = ".";
  string pathSeparator() {
    return _separator;
  }

  void pathSeparator(string separator) {
    _separator = separator;
  }
  // #endregion pathSeparator

  // #region path
  // #region has
  // #region hasAllPath
  bool hasAllPath(string[][] paths) {
    return paths.all!(path => hasPath(path));
  }
  // #endregion hasAllPath

  // #region hasAnyPath
  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }
  // #endregion hasAnyPath

  // #region hasPath
  bool hasPath(string[] path) {
    return hasKey(path.toKey(_separator));
  }
  // #endregion hasPath
  // #endregion has

  // #region get
  string[][] paths() {
    return null;
  }

  // #region values
  Json[] values(string[][] paths) {
    return paths.map!(path => value(path)).array;
  }
  // #endregion values

  // #region value
  Json value(string[] path) {
    return value(path.toKey(_separator));
  }
  // #endregion value  
  // #endregion get

  // #region set
  // #region setAllPath
  bool setAllPath(string[][] paths, Json value) {
    return paths.all!(path => setPath(path, value));
  }
  // #region setAllPath

  // #region setAnyPath
  bool setAnyPath(string[][] paths, Json value) {
    return paths.any!(path => setPath(path, value));
  }
  // #endregion setAnyPath

  // #region setPath
  bool setPath(string[] path, Json value) {
    return setKey(path.toKey(_separator), value);
  }
  // #endregion setPath
  // #endregion set

  // #region merge
  // #region mergeAllPath
  bool mergeAllPath(string[][] paths, Json value) {
    return paths.all!(path => mergePath(path, value));
  }
  // #endregion mergeAllPath

  // #region mergeAnyPath
  bool mergeAnyPath(string[][] paths, Json value) {
    return paths.any!(path => mergePath(path, value));
  }
  // #endregion mergeAnyPath

  // #region mergePath
  bool mergePath(string[] path, Json value) {
    return mergeKey(path.toKey(_separator), value);
  }
  // #endregion mergePath
  // #endregion merge

  // #region update
  // #region updateAllPath
  bool updateAllPath(string[][] paths, Json value) {
    return paths.all!(path => updatePath(path, value));
  }
  // #endregion updateAllPath

  // #region updateAnyPath
  bool updateAnyPath(string[][] paths, Json value) {
    return paths.any!(path => updatePath(path, value));
  }
  // #endregion updateAnyPath

  // #region updatePath
  bool updatePath(string[] path, Json value) {
    return updateKey(path.toKey(_separator), value);
  }
  // #endregion updatePath
  // #endregion update

  // #region remove
  // #region removeAllPath
  bool removeAllPath(string[][] paths) {
    return paths.all!(path => removePath(path));
  }
  // #endregion removeAllPath

  // #region removeAnyPath
  bool removeAnyPath(string[][] paths) {
    return paths.any!(path => removePath(path));
  }
  // #endregion removeAnyPath

  // #region removePath
  bool removePath(string[] path) {
    return removeKey(path.toKey(_separator));
  }
  // #endregion removePath
  // #endregion remove
  // #endregion paths

  // #region keys
  // #region has
  // #region hasAllKey
  bool hasAllKey(string[] keys) {
    return keys.all!(key => hasKey(key));
  }
  // #endregion hasAllKey

  // #region hasAnyKey
  bool hasAnyKey(string[] keys) {
    return keys.any!(key => hasKey(key));
  }
  // #endregion hasAnyKey

  // #region hasKey
  bool hasKey(string key) {
    return hasKey(key.correctKey);
  }
  // #endregion hasKey
  // #endregion has

  // #region set
  bool setAllKey(Json[string] values) {
    return values.byKeyValue.all!(kv => setKey(kv.key, kv.value));
  }

  bool setAnyKey(Json[string] values) {
    return values.byKeyValue.any!(kv => setKey(kv.key, kv.value));
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
    return values.byKeyValue.all!(kv => mergeKey(kv.key, kv.value));
  }

  bool mergeAnyKey(Json[string] values) {
    return values.byKeyValue.any!(kv => mergeKey(kv.key, kv.value));
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
    return values.byKeyValue.all!(kv => updateKey(kv.key, kv.value));
  }

  bool updateAnyKey(Json[string] values) {
    return values.byKeyValue.any!(kv => updateKey(kv.key, kv.value));
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
  // #region removeAllKey
  bool removeAllKey(string[] keys) {
    return keys.all!(key => removeKey(key));
  }
  // #endregion removeAllKey

  // #region removeAnyKey
  bool removeAnyKey(string[] keys) {
    return keys.any!(key => removeKey(key));
  }
  // #endregion removeAnyKey

  // #region removeKey
  bool removeKey(string key) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion removeAllKey
  // #endregion remove
  // #endregion keys

  // #region values
  // #region get
  // #region values
  Json[] values() {
    return keys.map!(key => value(key)).array;
  }

  Json[] values(string[] keys) {
    return keys.map!(key => value(key)).array;
  }
  // #endregion values

  // #region value
  Json value(string key) {
    return Json(null);
  }
  // #endregion value
  // #endregion get

  // #region removeAllValue
  bool removeAllValue(Json[] values) {
    return values.all!(value => removeValue(value));
  }
  // #endregion removeAllValue

  // #region removeAnyValue
  bool removeAnyValue(Json[] values) {
    return values.any!(value => removeValue(value));
  }
  // #endregion removeAnyValue

  // #region removeValue
  bool removeValue(Json value) {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion removeValue

  // #region clear
  bool clear() {
    // TODO: Implement in subclasses
    return false; // to be implemented in subclasses
  }
  // #endregion clear
  // #endregion values
}
