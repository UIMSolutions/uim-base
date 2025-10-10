/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.containers.arrays.every;

import uim.phobos;

mixin(Version!"test_uim_phobos");
@safe:

void every(K, V)(V[K] items, void delegate(K key, V value) @safe func) {
  items.byKeyValue.each!(kv => func(kv.key, kv.value));
}

void every(K, V)(V[K] items, void delegate(V value) @safe func) {
  items.byValue.each!(v => func(v));
}

void every(V)(auto ref V[] items, void delegate(V value) @safe func) {
  items.each!(v => func(v));
}

unittest {
  // Test every with associative array and key-value delegate
  int[string] aa = ["a": 1, "b": 2, "c": 3];
  string keys;
  int valuesSum = 0;
  aa.every((string k, int v) { keys ~= k; valuesSum += v; });
  assert(keys.length == 3);
  assert(valuesSum == 6);
}

unittest {
  // Test every with associative array and value-only delegate
  int[string] aa = ["x": 10, "y": 20];
  int sum = 0;
  aa.every((int v) { sum += v; });
  assert(sum == 30);
}

unittest {
  // Test every with array and value-only delegate
  auto arr = [4, 5, 6];
  int product = 1;
  arr.every((int v) { product *= v; });
  assert(product == 120);
}

unittest {
  // Test every with empty associative array
  int[string] aa;
  int count = 0;
  aa.every((string k, int v) { count++; });
  assert(count == 0);
}

unittest {
  // Test every with empty array
  int[] arr;
  int count = 0;
  arr.every((int v) { count++; });
  assert(count == 0);
}

unittest {
  int buffer;
  [1, 2, 3].every((int value) { buffer += value; });
  assert(buffer == 6);
}
