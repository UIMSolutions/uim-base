module uim.vibe.datatypes.jsons.json.is_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

bool isArray(Json json, string key) {
  return json.isObject && json.hasKey(key) && json[key].isArray;
}
