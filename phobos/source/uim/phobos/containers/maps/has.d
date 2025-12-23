module uim.phobos.containers.maps.has;

import uim.phobos;

mixin(Version!"test_uim_phobos");

@safe:

bool hasAllKey(K, V)(V[K] items, K[] keys) {
  return keys.all!(key => hasKey(items, key));
}

bool hasAnyKey(K, V)(V[K] items, K[] keys) {
  return keys.any!(key => hasKey(items, key));
}

bool hasKey(K, V)(V[K] items, K key) {
  return (key in items) ? true : false;
}

bool hasAllValue(K, V)(V[K] items, V[] values) {
  return values.all!(value => hasValue(items, value));
}

bool hasAnyValue(K, V)(V[K] items, V[] values) {
  return values.any!(value => hasValue(items, value));
}

bool hasValue(K, V)(V[K] items, V value) {
  foreach (k, v; items) {
    if (v == value) {
      return true;
    }
  }
  return false;
}
