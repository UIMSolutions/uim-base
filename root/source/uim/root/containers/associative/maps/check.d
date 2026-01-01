module uim.root.containers.associative.maps.check;

import uim.root;

mixin(Version!("test_uim_phobos"));

@safe:

bool isNull(K, V)(V[K] map) {
  return map is null;
}

bool isEmpty(K, V)(V[K] map) {
  return map.length == 0;
}

bool isSingle(K, V)(V[K] map) {
  return map.length == 1;
}

bool isMulti(K, V)(V[K] map) {
  return map.length > 1;
}