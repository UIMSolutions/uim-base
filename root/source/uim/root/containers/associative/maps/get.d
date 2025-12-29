module uim.root.containers.associative.maps.get;

import uim.root;

mixin(Version!"test_uim_root");

@safe:

V getValue(K, V)(V[K] map, K key, V defaultValue = Null!V) {
  return key in map ? map[key] : defaultValue;
}