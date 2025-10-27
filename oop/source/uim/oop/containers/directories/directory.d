/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directoriess.directories;

mixin(Version!"test_uim_oop");

import uim.oop;

@safe:

class DDirectoryMap(V) : DMap!(string, V) {
  mixin(MapThis!("Directories"));

  // #region pathSeparator
  protected string _pathSeparator = ".";

  // Gets the path separator used in the directories.
  string pathSeparator() {
    return _pathSeparator;
  }

  // Sets the path separator used in the directories.
  bool pathSeparator(string separator) {
    _pathSeparator = separator;
  }
  // #endregion pathSeparator

  // #region paths
  // Gets all paths in the map, sorted according to the specified order.
  string[][] paths() {
    return _elements.keys.map!(key => key.split(_pathSeparator)).array;
  }

  // #region has
  // Checks if all specified paths exist in the map.
  bool hasAllPath(string[][] paths) {
    return paths.all!(path => hasPath(path));
  }
  /// 
  unittest {
    // prepare map and paths
    auto map = new DDirectoryMap!int;
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

  // Checks if any of the specified paths exist in the map.
  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }
  /// 
  /// Params:
  ///   path = 
  /// Returns: 

  // Checks if a specific path exists in the map.
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
  bool setAllPath(string[][] paths, V value) {
    return paths.all!(p => setPath(p, value));
  }

  // Sets any of the specified paths to the item.
  bool setAnyPath(string[][] paths, V value) {
    return paths.any!(p => setPath(p, value));
  }

  // Sets a specific item in the map.
  bool setPath(string[] path, V value) {
    return set(path.toKey, value);
  }
  // #endregion set

  // #region update
  // #region updateAllPaths
  bool updateAllPath(string[][] paths, V value) {
    return paths.all!(p => updatePath(p, value));
  }
  /// 
  unittest {
    // All paths exist -> should return true and update all
    auto dir1 = new DDirectoryMap!int;
    string[] p1 = ["foo", "bar"];
    string[] p2 = ["baz"];

    dir1.setPath(p1, 1);
    dir1.setPath(p2, 2);

    bool res = dir1.updateAllPath([p1, p2], 10);
    assert(res, "updateAllPath should return true when all paths exist");
    assert(dir1.itemByPath(p1) == 10, "p1 should be updated to 10");
    assert(dir1.itemByPath(p2) == 10, "p2 should be updated to 10");

    // Mixed existing and non-existing -> should return false,
    // existing ones encountered before missing will be updated (behavior follows implementation)
    auto dir2 = new DDirectoryMap!int;
    string[] existing = ["a"];
    string[] missing = ["no", "such"];

    dir2.setPath(existing, 5);

    bool res = dir2.updateAllPath([existing, missing], 9);
    assert(!res, "updateAllPath should return false when at least one path does not exist");
    // existing path was updated by implementation before failing on missing
    assert(dir2.itemByPath(existing) == 9, "existing path should have been updated before failure");
    assert(!dir2.hasPath(missing), "missing path must remain absent");

    // Empty array -> vacuously true and nothing changed
    auto dir3 = new DDirectoryMap!int;
    string[] p = ["x"];
    dir3.setPath(p, 7);

    bool res = dir3.updateAllPath([], 99);
    assert(res, "updateAllPath with empty array should return true");
    assert(dir3.itemByPath(p) == 7, "existing items should remain unchanged when no paths provided");

    // Duplicate paths where the path exists -> should return true and be updated
    auto dir4 = new DDirectoryMap!int;
    string[] dup = ["dup"];

    dir4.setPath(dup, 3);

    bool res = dir4.updateAllPath([dup, dup], 42);
    assert(res, "updateAllPath should return true when duplicates include an existing path");
    assert(dir4.itemByPath(dup) == 42, "duplicate path should be updated to new value");
  }
  // #endregion updateAllPaths

  // #region updateAnyPaths
  bool updateAnyPath(string[][] paths, V value) {
    return paths.any!(p => updatePath(p, value));
  }
  ///
  unittest {
    // At least one path exists -> should return true and update existing ones only
    auto dir1 = new DDirectoryMap!int;
    string[] pathExisting1 = ["foo", "bar"];
    string[] pathExisting2 = ["baz"];
    string[] pathMissing = ["no", "such"];

    dir1.setPath(pathExisting1, 10);
    dir1.setPath(pathExisting2, 20);

    string[][] mix = [pathMissing, pathExisting1];
    bool updated = dir1.updateAnyPath(mix, 99);
    assert(updated, "updateAnyPath should return true when at least one path is updated");
    assert(dir1.itemByPath(pathExisting1) == 99, "existing path should be updated");
    assert(dir1.itemByPath(pathExisting2) == 20, "other existing path should remain unchanged");
    assert(!dir1.hasPath(pathMissing), "missing path must remain absent");

    // No paths exist -> should return false and not create entries
    auto dir2 = new DDirectoryMap!int;
    string[] p1 = ["a"];
    string[] p2 = ["b"];
    string[][] noneExist = [p1, p2];

    updated = dir2.updateAnyPath(noneExist, 1);
    assert(!updated, "updateAnyPath should return false when no paths exist");
    assert(!dir2.hasPath(p1) && !dir2.hasPath(p2), "no new keys should be created");

    // Duplicate paths where the path exists -> should return true and update once
    auto dir3 = new DDirectoryMap!int;
    string[] p = ["dup"];
    dir3.setPath(p, 5);

    string[][] duplicates = [p, p];
    updated = dir3.updateAnyPath(duplicates, 7);
    assert(updated, "updateAnyPath should return true when duplicates include an existing path");
    assert(dir3.itemByPath(p) == 7, "path should be updated to the new value");
  }
  // #endregion updateAnyPaths

  // #region updatePath
  // Updates a specific item in the map.
  bool updatePath(string[] path, V value) {
    return updateKey(path.toKey, value);
  }
  ///
  unittest {
    // Test updatePath for DDirectoryMap!int
    auto dir1 = new DDirectoryMap!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];

    // Insert initial items
    dir1.setPath(path1, 100);
    dir1.setPath(path2, 200);

    // Update existing path
    bool updated = dir1.updatePath(path1, 101);
    assert(updated, "updatePath should return true for existing path");
    assert(dir1.itemByPath(path1) == 101, "item at path1 should be updated to 101");

    // Update another existing path
    updated = dir1.updatePath(path2, 201);
    assert(updated, "updatePath should return true for another existing path");
    assert(dir1.itemByPath(path2) == 201, "item at path2 should be updated to 201");

    // Update non-existing path
    updated = dir1.updatePath(path3, 300);
    assert(!updated, "updatePath should return false for non-existing path");
    assert(!dir1.hasPath(path3), "non-existing path should not be created by updatePath");
  }
  // #endregion updatePath
  // #endregion update

  // #region merge
  // Merges the entire map with the specified item.
  bool mergePaths(string[][] paths, V value) {
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
  bool mergePath(string[] path, V value) {
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

    // Inserv values
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
}
