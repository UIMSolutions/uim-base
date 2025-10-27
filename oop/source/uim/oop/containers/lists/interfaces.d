/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.lists.interfaces;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

interface IList(T) : IContainer {
  /* size_t indexOf(T value);
    T opIndex(size_t index);
    void insert(size_t index, T value);
    void removeAt(size_t index);
    void clear();
    void sort(int delegate(T a, T b) comparator);
    void reverse();
    IList!T opSlice(size_t from, size_t to);
    IList!T opSlice(size_t from);
    IList!T opSlice(); */
}
