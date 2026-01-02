module uim.root.containers.associative.maps.check;

import uim.root;

mixin(Version!("test_uim_phobos"));

@safe:

bool isNull(K, V)(V[K] map) {
  return map is null;
}
///
unittest {
  version (test_uim_phobos)
    writeln("Testing isNull function");

  int[string] map = null;
  assert(map.isNull());

  map = ["a": 1];
  assert(!map.isNull());
}

bool isEmpty(K, V)(V[K] map) {
  return map.length == 0;
}
///
unittest {
  version (test_uim_phobos)
    writeln("Testing isEmpty function");

  int[string] map = null;
  assert(map.isEmpty());

  map = ["a": 1];
  assert(!map.isEmpty());
}

bool isSingle(K, V)(V[K] map) {
  return map.length == 1;
}
///
unittest {
  version (test_uim_phobos)
    writeln("Testing isSingle function");

  int[string] map = ["a": 1];
  assert(map.isSingle());

  map = ["a": 1, "b": 2];
  assert(!map.isSingle());
}

bool isMulti(K, V)(V[K] map) {
  return map.length > 1;
}
///
unittest {
  version (test_uim_phobos)
    writeln("Testing isMulti function");

  int[string] map = ["a": 1, "b": 2];
  assert(map.isMulti());

  map = ["a": 1];
  assert(!map.isMulti());
}