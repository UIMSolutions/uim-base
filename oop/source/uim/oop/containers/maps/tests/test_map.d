module uim.oop.containers.maps.tests.test_map;

import uim.oop.containers.maps.map;

unittest {
    // clear() on a non-empty map should return true and remove all entries
    auto map = new UIMMap!(string, int);
    map.entries = ["a": 1, "b": 2, "c": 3];
    assert(map.size() == 3);
    map.clear;
    assert(map.size() == 0);
    assert(!map.hasKey("a"));
    assert(!map.hasKey("b"));
    assert(!map.hasKey("c"));
    assert(!map.hasValue(1));
    assert(!map.hasValue(2));
    assert(!map.hasValue(3));
}

unittest {
    // clear() on an already empty map should still return true and keep it empty
    auto map = new UIMMap!(string, int);
    assert(map.size() == 0);
    map.clear();
    assert(map.size() == 0);
    // still no keys/values
    assert(!map.hasKey("nonexistent"));
    assert(!map.hasValue(999));
}
unittest {
    // removeKey() should remove multiple keys from the map
    auto map = ["a": 1, "b": 2, "c": 3, "d": 4];
    auto result = MapHelper.removeKey(map, ["b", "d"]);
    assert(result.length == 2);
    assert("a" in result);
    assert("c" in result);
    assert("b" !in result);
    assert("d" !in result);
    assert(result["a"] == 1);
    assert(result["c"] == 3);
}

unittest {
    // removeKey() with empty key array should return unchanged map
    auto map = ["a": 1, "b": 2, "c": 3];
    auto result = MapHelper.removeKey(map, []);
    assert(result.length == 3);
    assert(result == map);
}

unittest {
    // removeKey() with non-existent keys should not modify the map
    auto map = ["a": 1, "b": 2];
    auto result = MapHelper.removeKey(map, ["x", "y", "z"]);
    assert(result.length == 2);
    assert(result == map);
}

unittest {
    // removeKey() with mixed existing and non-existing keys
    auto map = ["a": 1, "b": 2, "c": 3];
    auto result = MapHelper.removeKey(map, ["b", "nonexistent", "c"]);
    assert(result.length == 1);
    assert("a" in result);
    assert(result["a"] == 1);
    assert("b" !in result);
    assert("c" !in result);
}

unittest {
    // removeKey() removing all keys should result in empty map
    auto map = ["x": 10, "y": 20];
    auto result = MapHelper.removeKey(map, ["x", "y"]);
    assert(result.length == 0);
    assert("x" !in result);
    assert("y" !in result);
}
