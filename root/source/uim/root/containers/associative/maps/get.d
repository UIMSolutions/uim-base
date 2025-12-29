module uim.root.containers.associative.maps.get;

import uim.root;

mixin(Version!"test_uim_root");

@safe:

V getValue(K, V)(V[K] values, K key, V defaultValue = Null!V) {
  return key in values ? values[key] : defaultValue;
}