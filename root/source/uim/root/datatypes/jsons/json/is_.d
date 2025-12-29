module uim.root.datatypes.jsons.json.is_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

bool isArray(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isArray;
}
