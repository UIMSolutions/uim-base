module uim.vibe.datatypes.jsons.objects.types.nulls.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasNull(Json[string] obj) {
  return obj.byValue.any!(v => v.isNull);
}