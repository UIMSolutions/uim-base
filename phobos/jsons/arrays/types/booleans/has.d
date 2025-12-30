module uim.root.datatypes.jsons.arrays.types.booleans.has;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool hasOnlyBoolean(Json[] jsons) {
  return jsons.all!(json => isBoolean(json));
}

bool hasBoolean(Json[] jsons) {
  return jsons.any!(json => isBoolean(json));
}
