/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.arrays.helper;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool hasValue(T : IObject)(T[] items, T value) {
  return items.any!(item => item.isEqual(value));
}

bool hasValue(T : UIMObject)(T[] items, T value) {
  return items.any!(item => item.isEqual(value));
}

unittest {
  class TestObj : UIMObject {
    this(string name) {
      this.name(name);
    }

    override bool isEqual(IObject other) {
      auto o = cast(TestObj) other;
      if (o is null) {
        return false;
      }
      return this.name == o.name;
    }
  }

  auto arr = [new TestObj("A"), new TestObj("B"), new TestObj("C")];
  assert(hasValue(arr, new TestObj("B")), "hasValue test failed");
  assert(!hasValue(arr, new TestObj("D")), "hasValue test failed");
}

