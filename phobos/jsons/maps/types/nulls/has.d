module uim.root.datatypes.jsons.maps.types.nulls.has;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

bool hasAnyNull(Json[string] obj) {
  if (obj is null) {
    return false;
  }
  return obj.byValue.any!(v => v.isNull);
}
