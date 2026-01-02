/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directories.directory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

/// A dynamic directory implementation using a map with string keys.
class UIMDirectory(V = UIMObject) : UIMMap!(string, V), IDirectory!V {
  mixin(DirectoryThis!());

  // #region pathSeparator
  protected string _pathSeparator = ".";

  // Gets the path separator used in the directory.
  string pathSeparator() {
    return _pathSeparator;
  }

  // Sets the path separator used in the directory.
  void pathSeparator(string separator) {
    _pathSeparator = separator;
  }
  // #endregion pathSeparator

  // #region paths
  // #region has
  // #region hasAllPath
  // Check if all paths are present in the map
  bool hasAllPath(string[][] paths) {
    return paths.all!(path => hasPath(path));
  }
  // #endregion hasAllPath

  // #region hasAnyPath
  // Check if any path is present in the map
  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }
  // #endregion hasAnyPath

  // #region hasPath
  /** 
    * Checks if a specific path exists in the directory.
    *
    * Params:
    *   path = The path to check, represented as an array of strings.
    *
    * Returns:
    *   true if the path exists, false otherwise.
    */
  override bool hasPath(string[] path) {
    return hasKey(path.toKey(_pathSeparator));
  }
  // #endregion hasPath
  // #endregion has

  // #region get  
  // #region paths
  // Gets all paths in the map, sorted according to the specified order.
  override string[][] paths() {
    return _entries.keys.map!(key => key.split(_pathSeparator)).array;
  }
  // #endregion paths

  // #region set
  // #region setAllPath
  /** 
    * Sets values at the specified paths in the directory.
    *
    * Params:
    *   paths = An array of paths where the values should be set, each represented as an array of strings.
    *   value = The value to set at the specified paths.
    *
    * Returns:
    *   true if all of the values were successfully set, false otherwise.
    */
  bool setAllPath(string[][] paths, V value) {
    return paths.all!(p => setPath(p, value));
  }
  // #endregion setAllPath

  // #region setAnyPath
  // Sets any of the specified paths to the item.
  bool setAnyPath(string[][] paths, V value) {
    return paths.any!(p => setPath(p, value));
  }
  // #endregion setAnyPath

  // #region setPath
  /** 
    * Sets a value at the specified path in the directory.
    *
    * Params:
    *   path = The path where the value should be set, represented as an array of strings.
    *   value = The value to set at the specified path.
    *
    * Returns:
    *   true if the value was successfully set, false otherwise.
    */
  bool setPath(string[] path, V value) {
    return setKey(path.toKey(_pathSeparator), value);
  }
  // #endregion setPath
  // #endregion set

  // #region update
  // #region updateAllPath
  /**
    * Updates values at the specified paths in the directory.
    *
    * Params:
    *   paths = An array of paths where the values should be updated, each represented as an array of strings.
    *   value = The value to update at the specified paths.
    *
    * Returns:
    *   true if all of the values were successfully updated, false otherwise.
    */ 
  bool updateAllPath(string[][] paths, V value) {
    return paths.all!(p => updatePath(p, value));
  }
  // #endregion updateAllPath

  // #region updateAnyPath
  /** 
    * Updates values at the specified paths in the directory.
    *
    * Params:
    *   paths = An array of paths where the values should be updated, each represented as an array of strings.
    *   value = The value to update at the specified paths.
    *
    * Returns:
    *   true if any of the values were successfully updated, false otherwise.
    */
  bool updateAnyPath(string[][] paths, V value) {
    return paths.any!(p => updatePath(p, value));
  }
  // #endregion updateAnyPath

  // #region updatePath
  /** 
    * Updates a value at the specified path in the directory.
    *
    * Params:
    *   path = The path where the value should be updated, represented as an array of strings.
    *   value = The value to update at the specified path.
    *
    * Returns:
    *   true if the value was successfully updated, false otherwise.
    */
  bool updatePath(string[] path, V value) {
    return updateKey(path.toKey(_pathSeparator), value);
  }
  // #endregion updatePath
  // #endregion update

  // #region merge
  // #region mergeAllPath
  /** 
    * Merges values at the specified paths in the directory.
    *
    * Params:
    *   paths = An array of paths where the values should be merged, each represented as an array of strings.
    *   value = The value to merge at the specified paths.
    *
    * Returns:
    *   true if all of the values were successfully merged, false otherwise.
    */
  bool mergeAllPath(string[][] paths, V value) {
    return paths.all!(p => mergePath(p, value));
  }
  // #endregion mergeAllPath

  // #region mergeAnyPath
  /** 
    * Merges values at the specified paths in the directory.
    *
    * Params:
    *   paths = An array of paths where the values should be merged, each represented as an array of strings.
    *   value = The value to merge at the specified paths.
    *
    * Returns:
    *   true if any of the values were successfully merged, false otherwise.
    */
  bool mergeAnyPath(string[][] paths, V value) {
    return paths.any!(p => mergePath(p, value));
  }
  // #endregion mergeAnyPath

  // #region mergePath
  /** 
    * Merges a value at the specified path in the directory.
    *
    * Params:
    *   path = The path where the value should be merged, represented as an array of strings.
    *   value = The value to merge at the specified path.
    *
    * Returns:
    *   true if the value was successfully merged, false otherwise.
    */
  bool mergePath(string[] path, V value) {
    return mergeKey(path.toKey(_pathSeparator), value);
  }
  // #endregion mergePath
  // #endregion merge

  // #region remove
  // #region removeAllPath
  // Remove multiple paths from the map
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
  // #region removePath
  /** 
    * Removes the item at the specified path from the directory.
    *
    * Params:
    *   path = The path of the item to remove, represented as an array of strings.
    *
    * Returns:
    *   true if the item was successfully removed, false if the path does not exist.
    */
  override bool removePath(string[] path) {
    if (path.length == 0 || !hasPath(path)) {
      return false;
    }
    return removeKey(path.toKey(_pathSeparator));
  }
  ///
  unittest {
    // Create a test map
    auto map = new UIMDirectory!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];

    // Inserv values
    map.setPath(path1, 42);
    map.setPath(path2, 99);

    // Remove existing path
    assert(map.hasPath(path1));
    bool removed = map.removePath(path1);
    assert(removed, "removePath should return true for existing path");
    assert(!map.hasPath(path1), "Path should be removed");

    // Remove non-existing path
    assert(!map.hasPath(path3));
    removed = map.removePath(path3);
    assert(!removed, "removePath should return false for non-existing path");

    // Remove after already removed
    removed = map.removePath(path1);
    assert(!removed, "removePath should return false when removing already removed path");

    // Remove another existing path
    assert(map.hasPath(path2));
    removed = map.removePath(path2);
    assert(removed, "removePath should return true for another existing path");
    assert(!map.hasPath(path2), "Second path should be removed");
  }
  // #endregion removePath
  // #endregion remove
  // #endregion paths

  // #region keys
  // #region set
  // #region setKey
  // Sets a specific item in the map.
  override bool setKey(string key, V value) {
    _entries[key.correctKey] = value;
    return true;
  }
  // #endregion setKey
  // #endregion set  
  // #endregion keys

  // #region get
  // #region values
  /** 
    * Retrieves values for the specified paths from the map.
    *
    * Params:
    *   paths = An array of paths to retrieve values for.
    *
    * Returns:
    *   An array of values corresponding to the specified paths.
    */
  V[] values(string[][] paths) {
    return paths
      .filter!(path => hasPath(path))
      .map!(path => value(path)).array;
  }

  /** 
    * Retrieves values for the specified keys from the map.
    *
    * Params:
    *   keys = An array of keys to retrieve values for. If null, retrieves all values.
    *
    * Returns:
    *   An array of values corresponding to the specified keys, or all values if keys is null.
    */
  override V[] values(string[] keys = null) {
    if (keys !is null) {
      return keys.map!(key => value(key)).array;
    }
    return _entries.values.array;
  }

  /** 
    * Gets the value associated with the specified path in the map.
    *
    * Params:
    *   path = The path whose associated value is to be returned, represented as an array of strings.
    *
    * Returns:
    *   The value associated with the specified path, or a default value if the path does not exist.
    */
  V value(string[] path) {
    return value(path.toKey(_pathSeparator));
  }

  /** 
    * Gets the value associated with the specified key in the map.
    *
    * Params:
    *   key = The key whose associated value is to be returned.
    *
    * Returns:
    *   The value associated with the specified key, or a default value if the key does not exist.
    */
  override V value(string key) {
    static if (is(V : IObject)) {
      return key.correctKey in _entries ? _entries[key.correctKey] : null;
    } else static if (is(V : UIMObject)) {
      return key.correctKey in _entries ? _entries[key.correctKey] : null;
    } else static if (is(V == Json)) {
      return key.correctKey in _entries ? _entries[key.correctKey] : Json(null);
    } else {
      return key.correctKey in _entries ? _entries[key.correctKey] : Null!V;
    }
  }
  // #endregion get 
  // #endregion values

  override V opCall(string key) {
    return value(key);
  }

  void opCall(V[string] entries) {
    foreach (key, value; entries) {
      setKey(key, value);
    }
  }

  V opCall(string[] path) {
    return value(path);
  }

  void opCall(string[] path, V value) {
    setPath(path, value);
  }
}
///
unittest { //   bool hasAllPath(string[][] paths) {
  // prepare map and paths
  auto map = new UIMDirectory!int;
  string[] path1 = ["foo", "bar"];
  string[] path2 = ["baz"];
  string[] path3 = ["qux", "quux"];

  // set some entries
  assert(map.setPath(path1, 1));
  assert(map.setPath(path2, 2));

  // all existing paths -> true
  string[][] allExisting = [path1, path2];
  assert(map.hasAllPath(allExisting));

  // mixed existing and non-existing -> false
  string[][] mixed = [path1, path3];
  assert(!map.hasAllPath(mixed));

  // all non-existing -> false
  string[][] nonExisting = [path3];
  assert(!map.hasAllPath(nonExisting));

  // empty array -> vacuously true
  string[][] empty = [];
  assert(map.hasAllPath(empty));

  // duplicate paths where the path exists -> true
  string[][] duplicates = [path1, path1];
  assert(map.hasAllPath(duplicates));
}
