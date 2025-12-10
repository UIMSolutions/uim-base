module uim.vibe.datatypes.jsons.objects.types.booleans.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasBoolean(Json[string] obj) {
  return obj.byValue.any!(v => v.isBoolean);
}