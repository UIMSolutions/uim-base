module uim.oop.containers.maps.subclasses.d.directory;

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

  // Gets a specific item from the map.
  T itemByPath(string[] path) {
    return itemByKey(path.toKey);
  }
  // #endregion get

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
  // Updates the entire map to the specified item.
  bool updatePaths(string[][] paths, T item) {
    return paths.all!(p => updatePath(p, item));
  }

  // Updates a specific item in the map.
  bool updatePath(string[] path, T item) {
    return updateKey(path.toKey, item);
  }
  // #endregion update

  // #region merge
  // Merges the entire map with the specified item.
  bool mergePaths(string[][] paths, T item) {
    return paths.all!(p => mergePath(p, item));
  }

  // Merges a specific item into the map.
  bool mergePath(string[] path, T item) {
    return mergeKey(path.toKey, item);
  }
  // #endregion merge

  // #region remove
  bool removePaths(string[][] paths) {
    return paths.all!(path => removePath(path));
  }

  bool removePath(string[] path) {
    return removeKey(path.toKey);
  }

  unittest {
    auto map = new DMap!string;

    // Add items with hierarchical keys
    map.setKey("a.b.c", "value1");
    map.setKey("x.y", "value2");
    map.setKey("single", "value3");

    // Remove multiple paths
    string[][] pathsToRemove = [
      ["a", "b", "c"],
      ["x", "y"]
    ];

    assert(map.hasPath(["a", "b", "c"]));
    assert(map.hasPath(["x", "y"]));
    assert(map.hasPath(["single"]));

    bool removed = map.removePaths(pathsToRemove);
    assert(removed);

    // Check that removed paths are gone
    assert(!map.hasPath(["a", "b", "c"]));
    assert(!map.hasPath(["x", "y"]));
    assert(map.hasPath(["single"]));

    // Remove single path
    assert(map.removePath(["single"]));
    assert(!map.hasPath(["single"]));

    // Try removing non-existent path
    assert(map.removePath(["not", "exist"])); // Should not throw, returns true/false depending on implementation
  }
  // #endregion remove
  // #endregion paths
}
