module uim.vibe.datatypes.jsons.json.remove;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

V[string] remove(V : Json)(V[string] items, string key) {
  if (hasKey(items, key)) {
    items.remove(key);
  }
  return items;
}