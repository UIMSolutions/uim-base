module uim.root.containers.sequential.arrays.check;

import uim.root;

mixin(Version!("test_uim_phobos"));

@safe:

bool isNull(V)(V[] array) {
  return array is null;
}
///
unittest {
  version (test_uim_phobos)
    writeln("Testing isNull function");

  int[] array = null;
  assert(array.isNull());

  array = [];
  assert(!array.isNull());
}

bool isEmpty(V)(V[] array) {
  return array.length == 0;
}
///
unittest {
  version (test_uim_phobos)
    writeln("Testing isEmpty function");

  int[] array = null;
  assert(array.isEmpty());

  array = [1];
  assert(!array.isEmpty());
}

bool isSingle(V)(V[] array) {
  return array.length == 1;
}
///
unittest {
  version (test_uim_phobos)
    writeln("Testing isSingle function");

  int[] array = [1];
  assert(array.isSingle());

  array = [1, 2];
  assert(!array.isSingle());
} 

bool isMulti(V)(V[] array) {
  return array.length > 1;
}
///
unittest {
  version (test_uim_phobos)
    writeln("Testing isMulti function");

  int[] array = [1, 2];
  assert(array.isMulti());

  array = [1];
  assert(!array.isMulti());
}
