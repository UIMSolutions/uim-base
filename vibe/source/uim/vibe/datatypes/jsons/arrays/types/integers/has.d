module uim.vibe.datatypes.jsons.arrays.types.integers.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasOnlyInteger(Json[] jsons) {
  return jsons.all!(json => isInteger(json));
}

bool hasInteger(Json[] jsons) {
  return jsons.any!(json => isInteger(json));
}
