module uim.vibe.datatypes.jsons.maps.types.doubles.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasAnyDouble(Json[string] obj) {
  if (obj is null) {
    return false;
  }
  return obj.byValue.any!(v => v.isDouble);
}