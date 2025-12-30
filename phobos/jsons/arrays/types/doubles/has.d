module uim.root.datatypes.jsons.arrays.types.doubles.has;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool hasOnlyDouble(Json[] jsons) {
  return jsons.all!(json => isDouble(json));
}

bool hasDouble(Json[] jsons) {
  return jsons.any!(json => isDouble(json));
}
