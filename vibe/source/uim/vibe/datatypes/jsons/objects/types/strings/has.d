module uim.vibe.datatypes.jsons.objects.types.strings.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasString(Json[string] obj) {
  return obj.byValue.any!(v => v.isString);
}