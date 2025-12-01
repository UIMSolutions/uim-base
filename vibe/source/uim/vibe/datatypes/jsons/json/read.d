module uim.vibe.datatypes.jsons.json.read;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

mixin(GetJsonValue!("Json", "Json", "Json(null)"));

/** 
  * Retrieves the Json value.
  *
  * Params:
  *   json = The JSON value to retrieve.
  *   defaultValue = The default JSON value to return if the original is null (default is Json(null)).
  *
  * Returns:
  *   The JSON value or the default value if the original is null.
  */
Json getJson(Json json, Json defaultValue = Json(null)) {
  return json;
}