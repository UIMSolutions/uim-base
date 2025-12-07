module uim.vibe.datatypes.jsons.arrays.types.objects.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:


bool isAllObject(Json[] values) {
  return values.all!(value => uim.vibe.datatypes.jsons.json.types.object_.isObject(value));
}

bool isAllObject(Json[] values, size_t[] indices) {
  return indices.all!(index => values.isObject(index));
}

bool isAnyObject(Json[] values) {
  return values.any!(value => uim.vibe.datatypes.jsons.json.types.object_.isObject(value));
}

bool isAnyObject(Json[] values, size_t[] indices) {
  return indices.any!(index => values.isObject(index));
}

bool isObject(Json[] values, size_t index) {
  if (index >= values.length) {
    return false;
  } 

  return uim.vibe.datatypes.jsons.json.types.object_.isObject(values[index]);
}
