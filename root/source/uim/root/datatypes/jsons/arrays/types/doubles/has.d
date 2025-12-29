module uim.vibe.datatypes.jsons.arrays.types.doubles.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasOnlyDouble(Json[] jsons) {
  return jsons.all!(json => isDouble(json));
}

bool hasDouble(Json[] jsons) {
  return jsons.any!(json => isDouble(json));
}
