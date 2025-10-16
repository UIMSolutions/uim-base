/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directorys.directory;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

class DDirectoryMap(V) : DMap!(string, V) {
  mixin(MapThis!("Directory"));

  // #region pathSeparator
  protected string _pathSeparator = ".";
  string pathSeparator() {
    return _pathSeparator;
  }

  void pathSeparator(string separator) {
    _pathSeparator = separator;
  }
  // #endregion pathSeparator

  // #region paths
  override string[][] paths(SORTORDERS sortorder = NOSORT) {
    // TODO: Implement sorting for paths
    return _elements.keys.map!(key => key.split(_pathSeparator)).array;
  }

  // #region has
  bool hasAllPath(string[][] paths) {
    return paths.all!(path => hasPath(path));
  }

  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }

  bool hasPath(string[] path) {
    return hasKey(path.join(_pathSeparator));
  }
  // #endregion has

  // #region get
  // Gets the entire map as a map of paths to items.
  T[string] itemsByPath(string[][] paths) {
    T[string] foundItems;
    paths
      .map!(path => path.toKey)
      .filter!(key => hasKey(key))
      .each!(key => foundItems[key] = itemByKey(key));

    return foundItems;
  }

  // #region set
  // Sets the entire map to the specified item.
  bool setPaths(string[][] paths, T item) {
    return paths.all!(p => setPath(p, item));
  }

  // Sets a specific item in the map.
  bool setPath(string[] path, T item) {
    return set(path.toKey, item);
  }
  // #endregion set

  // #region update
  // #region updatePaths
  // Updates the entire map to the specified item.
  bool updatePaths(string[][] paths, T item) {
    return paths.all!(p => updatePath(p, item));
  }
  ///
  unittest {
    // Test updatePaths for DDirectoryMap!int
    auto map = new DDirectoryMap!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];

    // Insert initial items
    map.setPath(path1, 100);
    map.setPath(path2, 200);

    // Update existing paths
    string[][] pathsToUpdate = [path1, path2];
    bool updated = map.updatePaths(pathsToUpdate, 999);
    assert(updated, "updatePaths should return true when all paths exist");
    assert(map.itemByPath(path1) == 999, "item at path1 should be updated to 999");
    assert(map.itemByPath(path2) == 999, "item at path2 should be updated to 999");

    // Update with some non-existing paths
    string[][] mixedPaths = [path1, path3];
    updated = map.updatePaths(mixedPaths, 555);
    assert(!updated, "updatePaths should return false if any path does not exist");
    assert(map.itemByPath(path1) == 555, "item at path1 should be updated to 555");
    assert(!map.hasPath(path3), "path3 should not be created by updatePaths");

    // Update with all non-existing paths
    string[][] nonExistingPaths = [path3];
    updated = map.updatePaths(nonExistingPaths, 123);
    assert(!updated, "updatePaths should return false when no paths exist");
    assert(!map.hasPath(path3), "path3 should not be created by updatePaths");

    // Update with empty paths array
    updated = map.updatePaths([], 888);
    assert(updated, "updatePaths with empty array should return true (vacuously true)");
  }
  // #endregion updatePaths

  // #region updatePath
  // Updates a specific item in the map.
  bool updatePath(string[] path, T item) {
    return updateKey(path.toKey, item);
  }
  ///
  unittest {
    // Test updatePath for DDirectoryMap!int
    auto map = new DDirectoryMap!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];

    // Insert initial items
    map.setPath(path1, 100);
    map.setPath(path2, 200);

    // Update existing path
    bool updated = map.updatePath(path1, 101);
    assert(updated, "updatePath should return true for existing path");
    assert(map.itemByPath(path1) == 101, "item at path1 should be updated to 101");

    // Update another existing path
    updated = map.updatePath(path2, 201);
    assert(updated, "updatePath should return true for another existing path");
    assert(map.itemByPath(path2) == 201, "item at path2 should be updated to 201");

    // Update non-existing path
    updated = map.updatePath(path3, 300);
    assert(!updated, "updatePath should return false for non-existing path");
    assert(!map.hasPath(path3), "non-existing path should not be created by updatePath");
  }
  // #endregion updatePath
  /// 
  unittest {
    // Test updatePath

    auto map = new DDirectoryMap!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];

    // Insert initial items
    map.setPath(path1, 100);
    map.setPath(path2, 200);

    // Update existing path
    bool updated = map.updatePath(path1, 101);
    assert(updated, "updatePath should return true for existing path");
    assert(map.itemByPath(path1) == 101, "item at path1 should be updated to 101");

    // Update another existing path
    updated = map.updatePath(path2, 201);
    assert(updated, "updatePath should return true for another existing path");
    assert(map.itemByPath(path2) == 201, "item at path2 should be updated to 201");

    // Update non-existing path
    updated = map.updatePath(path3, 300);
    assert(!updated, "updatePath should return false for non-existing path");
    assert(!map.hasPath(path3), "non-existing path should not be created by updatePath");
  }
  // #endregion update

  // #region merge
  // Merges the entire map with the specified item.
  bool mergePaths(string[][] paths, T item) {
    return paths.all!(path => mergePath(path, item));
  }
  /// 
  unittest {
    // Test mergePaths

    auto map = new DDirectoryMap!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];
    string[] path4 = ["qux"];

    // Insert initial items
    map.setPath(path1, 1);
    map.setPath(path2, 2);

    // Define a merge function for int (assume DMap uses addition for merge)
    // Merge into existing paths
    string[][] pathsToMerge = [path1, path2];
    bool merged = map.mergePaths(pathsToMerge, 10);
    assert(merged, "mergePaths should return true when all paths are merged");
    assert(map.itemByPath(path1) == 11, "path1 should be merged to 11");
    assert(map.itemByPath(path2) == 12, "path2 should be merged to 12");

    // Merge into non-existing paths (should create or fail depending on DMap's mergeKey logic)
    string[][] nonExistingPaths = [path3, path4];
    merged = map.mergePaths(nonExistingPaths, 5);
    // If mergeKey creates missing keys, these should exist now
    assert(map.hasPath(path3), "path3 should exist after merge if mergeKey creates keys");
    assert(map.hasPath(path4), "path4 should exist after merge if mergeKey creates keys");
    assert(map.itemByPath(path3) == 5, "path3 should be set to 5 after merge");
    assert(map.itemByPath(path4) == 5, "path4 should be set to 5 after merge");

    // Merge with empty paths
    merged = map.mergePaths([], 100);
    assert(merged, "mergePaths with empty array should return true (vacuously true)");
  }

  // #region mergePath
  // Merges a specific item into the map.
  bool mergePath(string[] path, T item) {
    return mergeKey(path.toKey, item);
  }
  ///
  unittest {
    // Test mergePath for DDirectoryMap!int
    auto map = new DDirectoryMap!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];

    // Insert initial items
    map.setPath(path1, 10);
    map.setPath(path2, 20);

    // Merge into existing path (assume mergeKey does addition)
    bool merged = map.mergePath(path1, 5);
    assert(merged, "mergePath should return true for existing path");
    assert(map.itemByPath(path1) == 15, "item at path1 should be merged to 15");

    // Merge into another existing path
    merged = map.mergePath(path2, 7);
    assert(merged, "mergePath should return true for another existing path");
    assert(map.itemByPath(path2) == 27, "item at path2 should be merged to 27");

    // Merge into non-existing path (should create if mergeKey creates keys)
    merged = map.mergePath(path3, 100);
    assert(merged, "mergePath should return true for non-existing path if mergeKey creates keys");
    assert(map.hasPath(path3), "path3 should exist after merge");
    assert(map.itemByPath(path3) == 100, "item at path3 should be set to 100 after merge");

    // Merge with empty path
    string[] emptyPath = [];
    merged = map.mergePath(emptyPath, 50);
    assert(merged, "mergePath should return true for empty path if mergeKey creates keys");
    assert(map.hasPath(emptyPath), "empty path should exist after merge");
    assert(map.itemByPath(emptyPath) == 50, "item at empty path should be set to 50 after merge");
  }
  // #endregion mergePath
  // #endregion merge

  // #region remove
  // #region removeAllPaths
  // Removes all specified paths were 
  bool removeAllPaths(string[][] paths) {
    return paths.all!(path => removePath(path));
  }
  // #endregion removeAllPaths

  // #region removeAnyPaths
  // Removes any specified paths were found
  bool removeAnyPaths(string[][] paths) {
    return paths.any!(path => removePath(path));
  }
  ///
  unittest {
    // Test removeAnyPaths

    auto map = new DDirectoryMap!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];
    string[] path4 = ["qux"];

    // Insert items
    map.setPath(path1, 1);
    map.setPath(path2, 2);

    // Case 1: At least one path exists
    string[][] paths = [path1, path3, path4];
    assert(map.hasPath(path1));
    assert(!map.hasPath(path3));
    assert(!map.hasPath(path4));
    bool result = map.removeAnyPaths(paths);
    assert(result, "removeAnyPaths should return true when at least one path is removed");
    assert(!map.hasPath(path1), "path1 should be removed");
    assert(!map.hasPath(path3), "path3 should remain absent");
    assert(!map.hasPath(path4), "path4 should remain absent");

    // Case 2: No paths exist
    string[][] nonExisting = [path3, path4];
    result = map.removeAnyPaths(nonExisting);
    assert(!result, "removeAnyPaths should return false when no paths are removed");

    // Case 3: Multiple existing paths
    map.setPath(path1, 10);
    map.setPath(path2, 20);
    string[][] multiPaths = [path1, path2];
    result = map.removeAnyPaths(multiPaths);
    assert(result, "removeAnyPaths should return true when multiple paths are removed");
    assert(!map.hasPath(path1));
    assert(!map.hasPath(path2));
  }
  // #endregion removeAnyPaths

  // #region removePath
  // Removes a specific item from the map.
  bool removePath(string[] path) {
    return removeKey(path.toKey);
  }
  ///
  unittest {
    // Create a test map
    auto map = new DDirectoryMap!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];

    // Helper to convert path to key
    string toKey(string[] path, string sep = ".") {
      return path.join(sep);
    }

    // Insert items
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
}
