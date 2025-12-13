module uim.vibe.datatypes.jsons.objects.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json[] filterObjects(Json[string] items) {
  return uim.vibe.containers.arrays.filter.filterObjects(items.byValue.array);
}


Json[] filterArrays(Json[string] items) {
  return uim.vibe.containers.arrays.filter.filterArrays(items.byValue.array);
}


Json[] filterValues(Json[string] items) {
  return uim.vibe.containers.arrays.filter.filterValues(items.byValue.array);
}
