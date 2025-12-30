module uim.root.datatypes.jsons.maps.types.doubles.has;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool hasAnyDouble(Json[string] obj) {
  if (obj is null) {
    return false;
  }
  return obj.byValue.any!(v => v.isDouble);
}