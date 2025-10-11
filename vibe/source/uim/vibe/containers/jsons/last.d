module uim.vibe.containers.jsons.last;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

Json last(Json json) {
  return json.isArray
    ? last(json.toArray) : Json(null);
}

Json lastObject(Json json) {
  return json.isArray
    ? json.toArray.filterObjects.last : Json(null);
}

Json lastArray(Json json) {
  return json.isArray
    ? json.toArray.filterArrays.last : Json(null);
}

Json lastValue(Json json) {
  return json.isArray
    ? json.toArray.filterValues.last : Json(null);
}

Json lastHasAllKeys(Json json, string[] keys) {
  return json.isArray
    ? json.toArray.filterHasAllKeys(keys).last : Json(null);
}

Json lastHasAnyKey(Json json, string[] keys) {
  return json.isArray
    ? json.toArray.filterHasAnyKey(keys).last : Json(null);
}

Json lastHasKey(Json json, string key) {
  return json.isArray
    ? json.toArray.filterHasKey(key).last : Json(null);
}
