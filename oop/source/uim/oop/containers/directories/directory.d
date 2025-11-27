/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directories.directory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

// A dynamic directory implementation using a map with string keys.
class DDirectory(V = UIMObject) : DMap!(string, V), IDirectory!V {
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
  // #endregion get  

  // #region set
  // #region setPath
  // Sets a specific item in the map.
  override bool setPath(string[] path, V value) {
    return setKey(path.toKey(_pathSeparator), value);
  }
  // #endregion setPath
  // #endregion set

  // #region remove
  // #region removePath
  // Removes a specific item from the map.
  override bool removePath(string[] path) {
    if (path.length == 0 || !hasPath(path)) {
      return false;
    }
    return removeKey(path.toKey(_pathSeparator));
  }
  ///
  unittest {
    // Create a test map
    auto map = new DDirectory!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];

    // Helper to convert path to key
    string toKey(string[] path, string sep = ".") {
      return path.join(sep);
    }

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
  // #region get  
  override string[] keys() {
    // return // _elements.keys.map!(key => key.correctKey).array;
    return null;
  }
  // #endregion get  

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
  override V getValue(string[] path) {
    return getValue(path.toKey(_pathSeparator));
  }

  override V getValue(string key) {
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

}

// #region tests
unittest { //   bool hasAllPath(string[][] paths) {
  // prepare map and paths
  auto map = new DDirectory!int;
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
// #endregion tests
