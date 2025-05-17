/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.algorithm.iteration;

import uim.phobos;
@safe:

void every(K, V)(V[K] items, void delegate(K key, V value) @safe func) {
  return items.byKeyValue.each!(kv => func(kv.key, kv.value));
}

void every(K, V)(V[K] items, void delegate(V value) @safe func) {
  return items.byValue.each!(v => func(v));
}

void every(V)(V[] items, void delegate(V value) @safe func) {
  return items.byValue.each!(v => func(v));
}

unittest {
    int buffer;
    [1, 2, 3].every((int value) => buffer += value);
    assert(buffer == 6);
} 
