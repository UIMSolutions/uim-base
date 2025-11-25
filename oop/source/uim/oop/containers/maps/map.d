/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.maps.map;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

class DMap(K = string, V = UIMObject) : UIMContainer, IMap!(K, V) {
  mixin(MapThis!());

  // Initializes this container with optional JSON data.
  override bool initialize(Json[string] initData = null) {
    name("Map");
    if (!super.initialize(initData)) {
      return false;
    }
    return true;
  }

  // #region entries
  protected V[K] _entries;
  V[K] entries() {
    return _entries.dup;
  }

  void entries(V[K] newEntries) {
    _entries = newEntries.dup;
  }
  // #endregion entries

  // #region size
  override size_t size() {
    return _entries.length;
  }
  // #endregion size

  // #region paths
  // #region has
  // #region hasAllPath
  // Check if all paths are present in the map
  bool hasAllPath(K[][] paths) {
    return paths.all!(path => hasPath(path));
  }
  // #endregion hasAllPath

  // #region hasAnyPath
  // Check if any path is present in the map
  bool hasAnyPath(K[][] paths) {
    return paths.any!(path => hasPath(path));
  }
  // #endregion hasAnyPath

  // #region hasPath
  // Check if a specific path is present in the map
  bool hasPath(K[] path) {
    return false;
  }
  // #endregion hasPath
  // #endregion has

  // #region get
  K[][] paths() {
    return null;
  }
  // #endregion get

  // #region set
  // #region setAllPath
  // Sets the entire map to the specified item.
  bool setAllPath(K[][] paths, V value) {
    return paths.all!(p => setPath(p, value));
  }
  // #endregion setAllPath

  // #region setAnyPath
  // Sets any of the specified paths to the item.
  bool setAnyPath(K[][] paths, V value) {
    return paths.any!(p => setPath(p, value));
  }
  // #endregion setAnyPath

  // #region setPath
  // Sets a specific item in the map.
  bool setPath(K[] path, V value) {
    return false;
  }
  // #endregion setPath
  // #endregion set

  // #region update
  // #region updateAllPath
  // Updates the entire map to the specified item.
  bool updateAllPath(K[][] paths, V value) {
    return paths.all!(p => updatePath(p, value));
  }
  // #endregion updateAllPath

  // #region updateAnyPath
  // Updates any of the specified paths to the item.
  bool updateAnyPath(K[][] paths, V value) {
    return paths.any!(p => updatePath(p, value));
  }
  // #endregion updateAnyPath

  // #region updatePath
  // Updates a specific item in the map.
  bool updatePath(K[] path, V value) {
    return hasPath(path) ? setPath(path, value) : false;
  }
  // #endregion updatePath
  // #endregion update

  // #region merge
  // #region mergeAllPath
  // Merges the entire map to the specified item.
  bool mergeAllPath(K[][] paths, V value) {
    return paths.all!(p => mergePath(p, value));
  }
  // #endregion mergeAllPath

  // #region mergeAnyPath
  // Merges any of the specified paths to the item.
  bool mergeAnyPath(K[][] paths, V value) {
    return paths.any!(p => mergePath(p, value));
  }
  // #endregion mergeAnyPath

  // #region mergePath
  // Merges a specific item in the map.
  bool mergePath(K[] path, V value) {
    return !hasPath(path) ? setPath(path, value) : false;
  }
  // #endregion mergePath
  // #endregion merge

  // #region remove
  // #region removeAllPath
  // Remove multiple paths from the map
  bool removeAllPath(K[][] paths) {
    return paths.all!(path => removePath(path));
  }
  // #endregion removeAllPath

  // #region removeAnyPath
  bool removeAnyPath(K[][] paths) {
    return paths.any!(path => removePath(path));
  }
  // #endregion removeAnyPath

  // #region removePath
  // Remove a single path from the map
  bool removePath(K[] path) {
    return false;
  }
  // #endregion removePath
  // #endregion remove
  // #endregion paths

  // #region keys
  // Retrieve all the names of the object's own enumerable properties.
  K[] keys() {
    return _entries.keys.array;
  }
  ///
  unittest {
    auto map = new DMap!(string, int);
    map.entries = ["a": 1, "b": 2, "c": 3];
    assert(map.keys().sort.array == ["a", "b", "c"]);
  }

  // #region has
  // #region hasAllKey
  // Check if all keys are present in the map
  bool hasAllKey(K[] keys) {
    return keys.all!(key => hasKey(key));
  }
  // #endregion hasAllKey

  // #region hasAnyKey
  // Check if any key is present in the map
  bool hasAnyKey(K[] keys) {
    return keys.any!(key => hasKey(key));
  }
  // #endregion hasAnyKey

  // #region hasKey
  // Check if a specific key is present in the map
  bool hasKey(K key) {
    return key in _entries ? true : false;
  }
  // #endregion hasKey
  // #endregion has

  // #region opIndexAssign
  // Assign a value to a specific key in the map
  void opIndexAssign(T)(T value, K key) {
    _entries[key] = value;
  }
  /// 
  unittest {
    auto map = new DMap!(string, int);
    map["x"] = 42;
    assert(map["x"] == 42);
    map["x"] = 99; // overwrite
    assert(map["x"] == 99);
  }
  // #endregion opIndexAssign

  // #region get
  // #region opIndex
  // Retrieve a value by its key from the map
  V opIndex(K key) {
    return value(key);
  }
  ///
  unittest {
    {
      // Test opIndex for existing keys
      auto map = new DMap!(string, int);
      map.entries = ["alpha": 1, "beta": 2, "gamma": 3];
      assert(map["alpha"] == 1);
      assert(map["beta"] == 2);
      assert(map["gamma"] == 3);
    }

    {
      // Test opIndex for non-existing keys
      auto map = new DMap!(string, int);
      map.entries = ["alpha": 1, "beta": 2];
      assert(map["gamma"] == Null!int);
      assert(map["delta"] == Null!int);
    }

    {
      // Test opIndex with integer keys
      auto map = new DMap!(int, string);
      map.entries = [1: "one", 2: "two"];
      assert(map[1] == "one");
      assert(map[2] == "two");
    }
  }
  // #endregion opIndex
  // #endregion get

  // #region set
  // #region setAllKey
  bool setAllKey(V[K] items) {
    return items.byKey.all!(key => setKey(key, items[key]));
  }

  bool setAllKey(K[] keys, V newValue) {
    return keys.all!(key => setKey(key, newValue));
  }
  // #endregion setAllKey

  // #region setAnyKey
  bool setAnyKey(V[K] items) {
    return items.byKey.any!(key => setKey(key, items[key]));
  }

  bool setAnyKey(K[] keys, V newValue) {
    return keys.any!(key => setKey(key, newValue));
  }
  // #endregion setAnyKey

  // #region setKey
  bool setKey(K key, V newValue) {
    _entries[key] = newValue;
    return true;
  }
  // #endregion setKey
  // #endregion set

  // #region update
  // #region updateAllKey
  bool updateAllKey(V[K] items) {
    return items.byKey.all!(key => updateKey(key, items[key]));
  }

  bool updateAllKey(K[] keys, V newValue) {
    return keys.all!(key => updateKey(key, newValue));
  }
  // #endregion updateAllKey

  // #region updateAnyKey
  bool updateAnyKey(V[K] items) {
    return items.byKey.any!(key => updateKey(key, items[key]));
  }

  bool updateAnyKey(K[] keys, V newValue) {
    return keys.any!(key => updateKey(key, newValue));
  }
  // #endregion updateAnyKey

  // #region updateKey
  bool updateKey(K key, V newValue) {
    _entries[key] = newValue;
    return true;
  }
  // #endregion updateKey
  // #endregion update

  // #region merge
  // #region mergeAllKey
  bool mergeAllKey(V[K] items) {
    return items.byKey.all!(key => mergeKey(key, items[key]));
  }

  bool mergeAllKey(K[] keys, V newValue) {
    return keys.all!(key => mergeKey(key, newValue));
  }
  // #endregion mergeAllKey

  // #region mergeAnyKey
  bool mergeAnyKey(V[K] items) {
    return items.byKey.any!(key => mergeKey(key, items[key]));
  }

  bool mergeAnyKey(K[] keys, V newValue) {
    return keys.any!(key => mergeKey(key, newValue));
  }
  // #endregion mergeAnyKey

  // #region mergeKey
  bool mergeKey(K key, V newValue) {
    _entries[key] = newValue;
    return true;
  }
  // #endregion mergeKey
  // #endregion merge

  // #region remove
  // #region removeAllKey
  // Remove multiple keys from the map
  bool removeAllKey(K[] keys) {
    return keys.all!(key => removeKey(key));
  }
  /// 
  unittest {
    // Test removeAllKey removes multiple keys
    auto map1 = new DMap!(string, int);
    map1.entries = ["a": 1, "b": 2, "c": 3, "d": 4];
    map1.removeAllKey(["b", "d"]);
    assert(map1.entries == ["a": 1, "c": 3]);
    assert(!map1.hasKey("b"));
    assert(!map1.hasKey("d"));
    assert(map1.hasKey("a"));
    assert(map1.hasKey("c"));

    // Test removeAllKey with empty array (should not remove anything)
    auto map2 = new DMap!(string, int);
    map2.entries = ["x": 10, "y": 20];
    map2.removeAllKey([]);
    assert(map2.entries == ["x": 10, "y": 20]);

    // Test removeAllKey with keys not present (should not throw, just ignore)
    auto map3 = new DMap!(string, int);
    map3.entries = ["foo": 100, "bar": 200];
    map3.removeAllKey(["baz", "qux"]);
    assert(map3.entries == ["foo": 100, "bar": 200]);

    // Test removeAllKey removes all keys
    auto map4 = new DMap!(int, string);
    map4.entries = [1: "one", 2: "two", 3: "three"];
    map4.removeAllKey([1, 2, 3]);
    assert(map4.entries.length == 0);
  }
  // #endregion removeAllKey

  // #region removeAnyKey
  bool removeAnyKey(K[] keys) {
    return keys.any!(key => removeKey(key));
  }
  // #endregion removeAnyKey

  // #region removeKey
  // Remove a single key from the map
  bool removeKey(K key) {
    _entries.remove(key);
    return true;
  }
  /// 
  unittest {
    // Test removeKey removes an existing key
    auto map1 = new DMap!(string, int);
    map1.entries = ["a": 1, "b": 2, "c": 3];
    map1.removeKey("b");
    assert(map1.entries == ["a": 1, "c": 3]);
    assert(!map1.hasKey("b"));
    assert(map1.hasKey("a"));
    assert(map1.hasKey("c"));

    // Test removeKey with a key not present (should not throw)
    auto map2 = new DMap!(string, int);
    map2.entries = ["x": 10, "y": 20];
    map2.removeKey("z"); // "z" not present
    assert(map2.entries == ["x": 10, "y": 20]);

    // Test removeKey removes all keys one by one
    auto map3 = new DMap!(int, string);
    map3.entries = [1: "one", 2: "two", 3: "three"];
    map3.removeKey(1);
    map3.removeKey(2);
    map3.removeKey(3);
    assert(map3.entries.length == 0);

    // Test removeKey on empty map (should not throw)
    auto map4 = new DMap!(string, int);
    map4.entries = null;
    map4.removeKey("a");
    assert(map4.entries.length == 0);
  }
  // #endregion removeKey
  // #endregion remove
  // #endregion keys

  // #region values

  // #region has
  // #region hasAllValue
  // Check if all values are present in the map
  bool hasAllValue(V[] values) {
    return values.all!(value => hasValue(value));
  }
  /// 
  unittest {
    // Test hasAllValue with all values present
    auto map1 = new DMap!(string, int);
    map1.entries = ["a": 1, "b": 2, "c": 3];
    assert(map1.hasAllValue([1, 2, 3]) == true);

    // Test hasAllValue with some values missing
    auto map2 = new DMap!(string, int);
    map2.entries = ["a": 1, "b": 2];
    assert(map2.hasAllValue([1, 2, 3]) == false);
  }
  // #endregion hasAllValue

  // #region hasAnyValue
  // Check if any value is present in the map
  bool hasAnyValue(V[] values) {
    return values.any!(value => hasValue(value));
  }
  /// 
  unittest {
    // Test hasAnyValue with one value present
    auto map = new DMap!(string, int);
    map.entries = ["a": 1, "b": 2, "c": 3];
    assert(map.hasAnyValue([2, 4]) == true); // 2 is present

    // Test hasAnyValue with no values present
    assert(map.hasAnyValue([4, 5]) == false);

    // Test hasAnyValue with multiple values present
    assert(map.hasAnyValue([1, 2]) == true);
    assert(map.hasAnyValue([1, 4]) == true);

    // Test hasAnyValue with empty map
    auto emptyMap = new DMap!(string, int);
    emptyMap.entries= null;
    assert(emptyMap.hasAnyValue([1, 2, 3]) == false);
  }
  // #endregion hasAnyValue

  // #region hasValue
  // Check if a specific value is present in the map
  bool hasValue(V value) {
    return _entries.values.any!(a => a.isEqual(value));
  }
  ///
  unittest {
    // Test hasValue with value present
    auto map1 = new DMap!(string, int);
    map1.entries = ["a": 1, "b": 2, "c": 3];
    assert(map1.hasValue(1) == true);
    assert(map1.hasValue(2) == true);
    assert(map1.hasValue(3) == true);

    // Test hasValue with value not present
    auto map2 = new DMap!(string, int);
    map2.entries = ["a": 1, "b": 2];
    assert(map2.hasValue(3) == false);
    assert(map2.hasValue(0) == false);

    // Test hasValue with empty map
    auto map3 = new DMap!(string, int);
    map3.entries = null;
    assert(map3.hasValue(1) == false);

    // Test hasValue with string values
    auto map4 = new DMap!(int, string);
    map4.entries = [1: "one", 2: "two"];
    assert(map4.hasValue("one") == true);
    assert(map4.hasValue("two") == true);
    assert(map4.hasValue("three") == false);
  }
  // #endregion hasValue
  // #endregion has

  // #region get
  // #region values
  V[] values() {
    return _entries.values.array;
  }

  V[] values(K[][] paths) {
    return paths.map!(path => value(path)).array;
  }

  V[] values(K[] keys) {
    return keys.map!(key => value(key)).array;
  }
  // #endregion values

  // #region value
  V value(K[] path) {
    static if (is(V == Json)) {
      return Json(null);
    } else static if (is(V : Object)) {
      return null;
    } else static if (is(V : IObject)) {
      return null;
    } else {
      return Null!V;
    }
  }

  V value(K key) {
    static if (is(V == Json)) {
      return key in _entries ? _entries[key] : Json(null);
    } else static if (is(V : Object)) {
      return key in _entries ? _entries[key] : null;
    } else static if (is(V : IObject)) {
      return key in _entries ? _entries[key] : null;
    } else {
      return key in _entries ? _entries[key] : Null!V;
    }
  }
  ///
  unittest {
    auto map1 = new DMap!(string, int);
    map1.entries = ["x": 10, "y": 20, "z": 30];
    auto vals1 = map1.values();
    assert(vals1.sort.array == [10, 20, 30]);

    auto map2 = new DMap!(int, string);
    map2.entries = [1: "one", 2: "two"];
    auto vals2 = map2.values();
    assert(vals2.sort.array == ["one", "two"]);

    auto map3 = new DMap!(string, int);
    map3.entries = null;
    auto vals3 = map3.values();
    assert(vals3.length == 0);
  }
  // #endregion value
  // #endregion get

  // #region change
  // #endregion change

  // #region remove
  // #region removeAllValue
  // Remove multiple values from the map
  bool removeAllValue(V[] values) {
    return values.all!(value => removeValue(value));
  }
  ///
  unittest {
    // Test removeAllValue removes multiple values
    auto map1 = new DMap!(string, int);
    map1.entries = ["a": 1, "b": 2, "c": 3, "d": 2];
    bool result1 = map1.removeAllValue([2, 3]);
    // Only first occurrence of each value is removed
    assert(result1 == true);
    // "b":2 and "c":3 should be removed, "d":2 remains because only one "2" is removed
    assert(map1.entries == ["a": 1, "d": 2]);
    assert(!map1.hasValue(3));
    assert(map1.hasValue(2));
    assert(map1.hasValue(1));

    // Test removeAllValue with values not present
    auto map2 = new DMap!(string, int);
    map2.entries = ["x": 10, "y": 20];
    bool result2 = map2.removeAllValue([30, 40]);
    assert(result2 == false); // none removed
    assert(map2.entries == ["x": 10, "y": 20]);

    // Test removeAllValue with empty values array (should not remove anything)
    auto map3 = new DMap!(string, int);
    map3.entries = ["foo": 100, "bar": 200];
    bool result3 = map3.removeAllValue([]);
    assert(result3 == true); // vacuously true
    assert(map3.entries == ["foo": 100, "bar": 200]);
  }
  // #endregion removeAllValue

  // #region removeAnyValue
  bool removeAnyValue(V[] values) {
    return values.any!(value => removeValue(value));
  }
  // #endregion removeAnyValue

  // #region removeValue
  // Remove a specific value from the map
  bool removeValue(V value) {
    foreach (k, v; _entries) {
      /* if (v == value) {
        _entries.remove(k);
        return true; // Remove only the first occurrence
      } */
    }
    return false; // Value not found
  }
  ///
  unittest {
    // Test removeValue removes first occurrence only
    auto map1 = new DMap!(string, int);
    map1.entries = ["a": 1, "b": 2, "c": 2, "d": 3];
    bool removed = map1.removeValue(2);
    assert(removed == true);
    // Only "b":2 should be removed, "c":2 remains
    assert(map1.entries == ["a": 1, "c": 2, "d": 3]);
    assert(map1.hasValue(2) == true);

    // Remove value that is present only once
    removed = map1.removeValue(3);
    assert(removed == true);
    assert(!map1.hasValue(3));
    assert(map1.entries == ["a": 1, "c": 2]);

    // Remove value that is not present
    removed = map1.removeValue(99);
    assert(removed == false);
    assert(map1.entries == ["a": 1, "c": 2]);

    // Remove all occurrences by repeated calls
    removed = map1.removeValue(2);
    assert(removed == true);
    assert(!map1.hasValue(2));
    assert(map1.entries == ["a": 1]);

    // Remove from empty map
    auto map2 = new DMap!(string, int);
    map2.entries = null;
    removed = map2.removeValue(1);
    assert(removed == false);

    // Remove string value
    auto map3 = new DMap!(int, string);
    map3.entries = [1: "foo", 2: "bar", 3: "baz"];
    removed = map3.removeValue("bar");
    assert(removed == true);
    assert(map3.entries == [1: "foo", 3: "baz"]);
    assert(!map3.hasValue("bar"));
  }
  // #endregion removeValue
  // #endregion has

  // #region clear
  // Removes all of the elements from this map
  override void clear() {
    _entries = null;
  }
  ///
  unittest {
    // clear() on a non-empty map should return true and remove all entries
    auto map1 = new DMap!(string, int);
    map1.entries = ["a": 1, "b": 2, "c": 3];
    assert(map1.size() == 3);
    map1.clear;
    assert(map1.size() == 0);
    assert(!map1.hasKey("a"));
    assert(!map1.hasKey("b"));
    assert(!map1.hasKey("c"));
    assert(!map1.hasValue(1));
    assert(!map1.hasValue(2));
    assert(!map1.hasValue(3));

    // clear() on an already empty map should still return true and keep it empty
    auto map2 = new DMap!(string, int);
    assert(map2.size() == 0);
    map2.clear;
    assert(map2.size() == 0);
    // still no keys/values
    assert(!map2.hasKey("nonexistent"));
    assert(!map2.hasValue(999));
  }
  // #endregion clear
  // #endregion values
}
