module uim.vibe.datatypes.jsons.arrays.types.nulls.has;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool hasOnlyNull(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.nulls.isNull(value));
}

bool hasAnyNull(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.nulls.isNull(value));
}