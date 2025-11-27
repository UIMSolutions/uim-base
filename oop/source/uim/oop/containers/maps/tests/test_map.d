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