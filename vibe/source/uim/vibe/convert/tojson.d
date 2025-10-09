module uim.vibe.convert.tojson;

import uim.vibe;
mixin(Version!("test_uim_vibe"));

@safe:

Json toJson(string key, UUID value) {
  auto json = Json.emptyObject;
  json[key] = value.toJson;
  return json;
}

Json toJson(T : UUID)(T value) {
  return Json(value.toString);
}