module uim.vibe.datatypes.jsons.arrays.types.undefineds.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool isAllUndefined(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.undefined.isUndefined(value));
}

bool isAllUndefined(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isUndefined(index));
}

bool isAnyUndefined(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.undefined.isUndefined(value));
}

bool isAnyUndefined(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isUndefined(index));
}

bool isUndefined(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.undefined.isUndefined(values[index]);
}
