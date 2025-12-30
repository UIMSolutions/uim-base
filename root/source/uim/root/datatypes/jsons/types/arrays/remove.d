module uim.root.datatypes.jsons.types.arrays.remove;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json[] removeArrays(Json[] jsons, bool delegate(Json json) @safe removeFunc) {
  return jsons.removeValues(removeFunc).removeArrays;
}

Json[] removeArrays(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices, ((Json json) => json.isArray)).removeArrays;
}

Json[] removeArrays(Json[] jsons) {
  return jsons.removeValues((Json json) => json.isArray);
}