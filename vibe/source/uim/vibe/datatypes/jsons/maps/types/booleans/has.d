module uim.vibe.datatypes.jsons.maps.types.booleans.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasAnyBoolean(Json[string] obj) {
  if (obj is null) {
    return false;
  }
  return obj.byValue.any!(v => v.isBoolean);
}