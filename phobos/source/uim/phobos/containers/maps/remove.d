module uim.phobos.containers.maps.remove;

import uim.phobos;

mixin(Version!"test_uim_phobos");

@safe:

V[K] removeKeys(K, V)(V[K] items, K[] keys) {
  V[K] results;
  foreach (k, v; items.byKeyValue) {
    if (k !in keys) {
      results[k] = v;
    }
  }
  return results;
}