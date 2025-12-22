module uim.vibe.datatypes.jsons.maps.types.nulls.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasAnyNull(Json[string] obj) {
  if (obj is null) {
    return false;
  }
  return obj.byValue.any!(v => v.isNull);
}
