module uim.root.containers.sequential.arrays.check;

import uim.root;

mixin(Version!("test_uim_phobos"));

@safe:

bool isNull(V)(V[] array) {
  return array is null;
}

bool isEmpty(V)(V[] array) {
  return array.length == 0;
}

bool isSingle(V)(V[] array) {
  return array.length == 1;
}

bool isMulti(V)(V[] array) {
  return array.length > 1;
}