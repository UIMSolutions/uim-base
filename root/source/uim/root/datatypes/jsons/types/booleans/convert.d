module uim.root.datatypes.jsons.types.booleans.convert;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

bool toBoolean(Json json, size_t index) {
  return json.isBoolean(index) ? json.to!bool : false;
}

bool toBoolean(Json json, string key) {
  return json.isBoolean(key) ? json.to!bool : false;
}

bool toBoolean(Json json) {
  return json.isBoolean ? json.to!bool : false;
}