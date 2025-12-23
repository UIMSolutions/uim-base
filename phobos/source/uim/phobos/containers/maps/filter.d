module uim.phobos.containers.maps.filter;

import uim.phobos;

mixin(Version!"test_uim_phobos");

@safe:

V[K] filterKeys(K, V)(V[K] map, K[] keys) {
  V[K] results;
  foreach (key; keys) {
    if (map.hasKey(key)) {
      results[key] = map[key];
    }
  }
  return results;
}

V[K] filterKeys(K, V)(V[K] map, bool delegate(K key, V value) @safe filterFunc) {
  V[K] results;
  foreach (key, value; map) {
    if (map.hasKey(key) in map && filterFunc(key, map[key])) {
      results[key] = value;
    }
  }
  return results;
}
