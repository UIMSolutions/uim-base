module uim.vibe.datatypes.jsons.json.read;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

mixin(GetJsonValue!("Json", "Json", "Json(null)"));

/// Get the Json value (returns the Json itself).
Json getJson(Json json, Json defaultValue = Json(null)) {
  return json;
}