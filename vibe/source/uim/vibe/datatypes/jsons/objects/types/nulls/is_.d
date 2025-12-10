module uim.vibe.datatypes.jsons.objects.types.nulls.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:
// #region path
// #region all
bool isAllNull(Json[string] map, string[][] paths) {
  return paths.all!(p => map.isNull(p));
}
// #endregion all

// #region any
bool isAnyNull(Json[string] map, string[][] paths) {
  return paths.any!(p => map.isNull(p));
}
// #endregion any

// #region is
bool isNull(Json[string] map, string[] path) {
  if (map.length == 0 || path.length == 0) {
    return false;
  }

  auto root = path[0];
  if (!(root in map)) {
    return false;
  }

  return path.length == 1 ? map.isNull(root) : map[root].isNull(path[1 .. $]);
}
// #endregion is
// #endregion path

// #region key
// #region all
bool isAllNull(Json[string] map, string[] keys) {
  return keys.all!(key => map.isNull(key));
}
// #endregion all

// #region any
bool isAnyNull(Json[string] map, string[] keys) {
  return keys.any!(key => map.isNull(key));
}
// #endregion any

// #region is
bool isNull(Json[string] map, string key) {
  if (map.length == 0 || key.length == 0) {
    return false;
  }

  return key in map && map[key].isNull;
}
// #endregion is
// #endregion key

// #region all
bool isAllNull(Json[string] map) {
  return map.byValue.all!(v => v.isNull);
}
// #endregion all

// #region any
bool isAnyNull(Json[string] map) {
  return map.byValue.any!(v => v.isNull);
}
// #endregion any

bool isAllNull(Json[string] map, string[] keys) {
  if (map is null) {
    return false;
  }
  return keys.all!(key => map.isNull(key));
}


bool isAnyNull(Json[string] map, string[] keys) {
  if (map is null) {
    return true;
  }
  return keys.any!(index => map.isNull(index));
}

// #region is
bool isNull(Json[string] map) {
  return (map is null);
}
// #endregion is
