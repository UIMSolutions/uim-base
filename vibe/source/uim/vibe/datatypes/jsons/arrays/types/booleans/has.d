module uim.vibe.datatypes.jsons.arrays.types.booleans.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasOnlyBoolean(Json[] jsons) {
  return jsons.all!(json => isBoolean(json));
}

bool hasBoolean(Json[] jsons) {
  return jsons.any!(json => isBoolean(json));
}
