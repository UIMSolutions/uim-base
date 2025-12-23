module uim.phobos.containers.maps.filter;

import uim.phobos;

mixin(Version!"test_uim_phobos");

@safe:

// #region keys
Json[string] filterKeys(Json[string] items, string[] keys) {
  return keys.filter!(key => key in items).map!(key => items[key]).array;
}
// #region keys
