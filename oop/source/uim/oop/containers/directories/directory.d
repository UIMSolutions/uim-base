/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.directories.directory;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DDirectory(V = UIMObject) : DMap!(string, V), IDirectory!V {
  mixin(DirectoryThis!());

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
  // #region values
  // Return all of the values of the object's own properties.
  V[string] values(string[][] paths) {
    V[string] result;
    foreach (path; paths) {
      result[path.toKey] = value(path);
    }
    return result;
  }

  V value(string[] path) {
    return value(path.toKey);
  }
  // #endregion values

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

  // Checks if any of the specified paths exist in the map.
  bool hasAnyPath(string[][] paths) {
    return paths.any!(path => hasPath(path));
  }

  // Checks if a specific path exists in the map.
  bool hasPath(string[] path) {
    return hasKey(path.join(_pathSeparator));
  }
  // #endregion has

  // #region get
  // Gets the entire map as a map of paths to items.
  V[string] itemsByPath(string[][] paths) {
    V[string] foundItems;
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
  // #region updateAllPath
  bool updateAllPath(string[][] paths, V value) {
    return paths.all!(p => updatePath(p, value));
  }
  /// 
  unittest {
    // All paths exist -> should return true and update all
    auto dir1 = new DDirectory!int;
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
    auto dir2 = new DDirectory!int;
    string[] existing = ["a"];
    string[] missing = ["no", "such"];

    dir2.setPath(existing, 5);

    bool res = dir2.updateAllPath([existing, missing], 9);
    assert(!res, "updateAllPath should return false when at least one path does not exist");
    // existing path was updated by implementation before failing on missing
    assert(dir2.itemByPath(existing) == 9, "existing path should have been updated before failure");
    assert(!dir2.hasPath(missing), "missing path must remain absent");

    // Empty array -> vacuously true and nothing changed
    auto dir3 = new DDirectory!int;
    string[] p = ["x"];
    dir3.setPath(p, 7);

    bool res = dir3.updateAllPath([], 99);
    assert(res, "updateAllPath with empty array should return true");
    assert(dir3.itemByPath(p) == 7, "existing items should remain unchanged when no paths provided");

    // Duplicate paths where the path exists -> should return true and be updated
    auto dir4 = new DDirectory!int;
    string[] dup = ["dup"];

    dir4.setPath(dup, 3);

    bool res = dir4.updateAllPath([dup, dup], 42);
    assert(res, "updateAllPath should return true when duplicates include an existing path");
    assert(dir4.itemByPath(dup) == 42, "duplicate path should be updated to new value");
  }
  // #endregion updateAllPath

  // #region updateAnyPaths
  bool updateAnyPath(string[][] paths, V value) {
    return paths.any!(p => updatePath(p, value));
  }
  ///
  unittest {
    // At least one path exists -> should return true and update existing ones only
    auto dir1 = new DDirectory!int;
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
    auto dir2 = new DDirectory!int;
    string[] p1 = ["a"];
    string[] p2 = ["b"];
    string[][] noneExist = [p1, p2];

    updated = dir2.updateAnyPath(noneExist, 1);
    assert(!updated, "updateAnyPath should return false when no paths exist");
    assert(!dir2.hasPath(p1) && !dir2.hasPath(p2), "no new keys should be created");

    // Duplicate paths where the path exists -> should return true and update once
    auto dir3 = new DDirectory!int;
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
    // Test updatePath for DDirectory!int
    auto dir1 = new DDirectory!int;
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
  // #region mergeAllPath
  bool mergeAllPath(string[][] paths, V value) {
    return paths.all!(p => mergePath(p, value));
  }
  // #endregion mergeAllPath

  // #region mergeAnyPath
  bool mergeAnyPath(string[][] paths, V value) {
    return paths.any!(p => mergePath(p, value));
  }
  // #endregion mergeAnyPath

  // #region mergePath
  // Merges a specific item into the map.
  bool mergePath(string[] path, V value) {
    return mergeKey(path.toKey, item);
  }
  ///
  unittest {
    // Test mergePath for DDirectory!int
    auto directory = new DDirectory!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];

    // Insert initial items
    directory.setPath(path1, 10);
    directory.setPath(path2, 20);

    // Merge into existing path (assume mergeKey does addition)
    bool merged = directory.mergePath(path1, 5);
    assert(merged, "mergePath should return true for existing path");
    assert(directory.itemByPath(path1) == 15, "item at path1 should be merged to 15");

    // Merge into another existing path
    merged = directory.mergePath(path2, 7);
    assert(merged, "mergePath should return true for another existing path");
    assert(directory.itemByPath(path2) == 27, "item at path2 should be merged to 27");

    // Merge into non-existing path (should create if mergeKey creates keys)
    merged = directory.mergePath(path3, 100);
    assert(merged, "mergePath should return true for non-existing path if mergeKey creates keys");
    assert(directory.hasPath(path3), "path3 should exist after merge");
    assert(directory.itemByPath(path3) == 100, "item at path3 should be set to 100 after merge");

    // Merge with empty path
    string[] emptyPath = [];
    merged = directory.mergePath(emptyPath, 50);
    assert(merged, "mergePath should return true for empty path if mergeKey creates keys");
    assert(directory.hasPath(emptyPath), "empty path should exist after merge");
    assert(directory.itemByPath(emptyPath) == 50, "item at empty path should be set to 50 after merge");
  }
  // #endregion mergePath
  // #endregion merge

    // #region remove
  // #region removeAllPath
  // Removes all specified paths were 
  bool removeAllPath(string[][] paths) {
    return paths.all!(path => removePath(path));
  }
  // #endregion removeAllPath

  // #region removeAnyPath
  // Removes any specified paths were found
  bool removeAnyPath(string[][] paths) {
    return paths.any!(path => removePath(path));
  }
  ///
  unittest {
    // Test removeAnyPath

    auto directory = new DDirectory!int;
    string[] path1 = ["foo", "bar"];
    string[] path2 = ["baz"];
    string[] path3 = ["foo", "baz"];
    string[] path4 = ["qux"];

    // Insert values
    directory.setPath(path1, 1);
    directory.setPath(path2, 2);

    // Case 1: At least one path exists
    string[][] paths = [path1, path3, path4];
    assert(directory.hasPath(path1));
    assert(!directory.hasPath(path3));
    assert(!directory.hasPath(path4));
    bool result = directory.removeAnyPath(paths);
    assert(result, "removeAnyPath should return true when at least one path is removed");
    assert(!directory.hasPath(path1), "path1 should be removed");
    assert(!directory.hasPath(path3), "path3 should remain absent");
    assert(!directory.hasPath(path4), "path4 should remain absent");

    // Case 2: No paths exist
    string[][] nonExisting = [path3, path4];
    result = directory.removeAnyPath(nonExisting);
    assert(!result, "removeAnyPath should return false when no paths are removed");

    // Case 3: Multiple existing paths
    directory.setPath(path1, 10);
    directory.setPath(path2, 20);
    string[][] multiPaths = [path1, path2];
    result = directory.removeAnyPath(multiPaths);
    assert(result, "removeAnyPath should return true when multiple paths are removed");
    assert(!directory.hasPath(path1));
    assert(!directory.hasPath(path2));
  }
  // #endregion removeAnyPath

  // #region removePath
  // Removes a specific item from the map.
  bool removePath(string[] path) {
    return removeKey(path.toKey);
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
}
