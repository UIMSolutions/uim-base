module uim.oop.containers.arrays.helper;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool hasValue(T : IObject)(T[] items, in T value) {
  return items.any!(item => item.isEqual(value));
}

bool hasValue(T : UIMObject)(T[] items, in T value) {
  return items.any!(item => item.isEqual(value));
}
