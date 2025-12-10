module uim.vibe.datatypes.jsons.objects.types.doubles.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasDouble(Json[string] obj) {
  return obj.byValue.any!(v => v.isDouble);
}