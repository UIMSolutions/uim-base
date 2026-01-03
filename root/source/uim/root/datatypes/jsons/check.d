module uim.root.datatypes.jsons.check;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

bool isObject(Json json) {
  return (json.type == Json.Type.object);
}

bool isArray(Json json) {
  return (json.type == Json.Type.array);
}