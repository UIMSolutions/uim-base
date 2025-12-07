module uim.vibe.datatypes.jsons.arrays.types.nulls.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool isAllNull(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.nulls.isNull(value));
}

bool isAllNull(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isNull(index));
}

bool isAnyNull(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.nulls.isNull(value));
}

bool isAnyNull(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isNull(index));
}

bool isNull(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.nulls.isNull(values[index]);
}
