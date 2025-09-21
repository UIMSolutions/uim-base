/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.isset;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region Json[string]
bool allSet(Json[string] map, string[] keys) {
  return keys.all!(key => map.isSet(key));
}

bool anySet(Json[string] map, string[] keys) {
  return keys.any!(key => map.isSet(key));
}

bool isSet(Json[string] map, string key) {
  return key in map ? true : false;
}

unittest {
  // Mock Json type as alias for string for testing purposes
  alias Json = string;

  // Test isSet for Json[string]
  {
    Json[string] map = ["a": "1", "b": "2", "c": "3"];
    assert(isSet(map, "a"));
    assert(isSet(map, "b"));
    assert(isSet(map, "c"));
    assert(!isSet(map, "d"));
  }

  // Test allSet for Json[string]
  {
    Json[string] map = ["x": "foo", "y": "bar", "z": "baz"];
    assert(allSet(map, ["x", "y"]));
    assert(allSet(map, ["x", "y", "z"]));
    assert(!allSet(map, ["x", "y", "q"]));
    assert(allSet(map, [])); // vacuously true
  }

  // Test anySet for Json[string]
  {
    Json[string] map = ["k1": "v1", "k2": "v2"];
    assert(anySet(map, ["k1", "notfound"]));
    assert(anySet(map, ["notfound", "k2"]));
    assert(!anySet(map, ["none", "missing"]));
    assert(!anySet(map, []));
  }
}
// #endregion Json[string]

// #region json
bool allSet(Json json, string[] keys) {
  return keys.all!(key => json.isSet(key));
}

bool anySet(Json json, string[] keys) {
  return keys.any!(key => json.isSet(key));
}

bool isSet(Json json, string key) {
  if (json.isArray) {
    return json.toArray.any!(j => j.has(key));
  }
  if (json.isObject) {
    return json.has(key);
  }
  return false;
}

unittest {
  import std.algorithm : all, any;

  // Minimal mock Json type for testing
  static struct MockJson {
    bool isArray;
    bool isObject;
    MockJson[] arr;
    string[string] obj;

    MockJson opIndex(size_t i) const {
      return arr[i];
    }

    size_t length() const {
      return arr.length;
    }

    auto toArray() const {
      return arr;
    }

    bool has(string key) const {
      return key in obj;
    }
  }

  // Helper to create object Json
  MockJson makeObject(string[string] obj) {
    return MockJson(false, true, null, obj);
  }

  // Helper to create array Json
  MockJson makeArray(MockJson[] arr) {
    return MockJson(true, false, arr, null);
  }

  // Test isSet for object
  {
    auto json = makeObject(["foo": "bar", "baz": "qux"]);
    assert(isSet(json, "foo"));
    assert(isSet(json, "baz"));
    assert(!isSet(json, "notfound"));
  }

  // Test isSet for array of objects
  {
    auto arr = [
      makeObject(["a": "1"]),
      makeObject(["b": "2"]),
      makeObject(["c": "3"])
    ];
    auto json = makeArray(arr);
    assert(isSet(json, "a"));
    assert(isSet(json, "b"));
    assert(isSet(json, "c"));
    assert(!isSet(json, "d"));
  }

  // Test isSet for non-object, non-array
  {
    auto json = MockJson(false, false, null, null);
    assert(!isSet(json, "any"));
  }

  // Test allSet for object
  {
    auto json = makeObject(["x": "1", "y": "2", "z": "3"]);
    assert(allSet(json, ["x", "y"]));
    assert(allSet(json, ["x", "y", "z"]));
    assert(!allSet(json, ["x", "y", "q"]));
    assert(allSet(json, [])); // vacuously true
  }

  // Test anySet for object
  {
    auto json = makeObject(["k1": "v1", "k2": "v2"]);
    assert(anySet(json, ["k1", "notfound"]));
    assert(anySet(json, ["notfound", "k2"]));
    assert(!anySet(json, ["none", "missing"]));
    assert(!anySet(json, []));
  }

  // Test allSet for array of objects
  {
    auto arr = [
      makeObject(["a": "1", "b": "2"]),
      makeObject(["b": "3", "c": "4"])
    ];
    auto json = makeArray(arr);
    assert(allSet(json, ["a", "b"])); // "a" in first, "b" in both
    assert(!allSet(json, ["a", "c"])); // "c" only in second
  }

  // Test anySet for array of objects
  {
    auto arr = [
      makeObject(["foo": "bar"]),
      makeObject(["baz": "qux"])
    ];
    auto json = makeArray(arr);
    assert(anySet(json, ["foo"]));
    assert(anySet(json, ["baz"]));
    assert(anySet(json, ["foo", "baz"]));
    assert(!anySet(json, ["notfound"]));
  }
}

// #endregion json
