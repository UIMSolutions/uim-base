module uim.vibe.datatypes.jsons.objects.types.arrays.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasArray(Json[string] obj) {
  return obj.byValue.any!(v => v.isArray);
}