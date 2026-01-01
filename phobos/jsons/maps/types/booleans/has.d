module uim.root.datatypes.jsons.maps.types.booleans.has;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

bool hasAnyBoolean(Json[string] obj) {
  if (obj is null) {
    return false;
  }
  return obj.byValue.any!(v => v.isBoolean);
}

