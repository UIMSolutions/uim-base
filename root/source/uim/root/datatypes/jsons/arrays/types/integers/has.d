module uim.root.datatypes.jsons.arrays.types.integers.has;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool hasOnlyInteger(Json[] jsons) {
  return jsons.all!(json => isInteger(json));
}

bool hasInteger(Json[] jsons) {
  return jsons.any!(json => isInteger(json));
}
