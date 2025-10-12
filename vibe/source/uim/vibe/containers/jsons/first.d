module uim.vibe.containers.jsons.first;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:

Json first(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.toArray) : Json(null);
}
/// 
unittest {
  // Test with a non-array Json
  Json j1 = Json(42);
  assert(first(j1) == Json(null));

  // Test with an empty array
  Json j2 = Json.emptyArray;
  assert(first(j2) == Json(null));

  // Test with a single-element array
  Json j3 = Json([Json("a")]);
  assert(first(j3) == Json("a"));

  // Test with a multi-element array
  Json j4 = Json([Json("x"), Json("y"), Json("z")]);
  assert(first(j4) == Json("x"));

  // Test with nested arrays
  Json j5 = Json([Json([Json(1), Json(2)]), Json(3)]);
  assert(first(j5) == Json([Json(1), Json(2)]));
}

Json firstObject(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.filterObjects) : Json(null);
}

Json firstArray(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.filterArrays) : Json(null);
}

Json firstValue(Json json) {
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.filterValues) : Json(null);
}

Json firstHasAllKeys(Json json, string[] keys) {
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.toArray.filterHasAllKeys(keys)) : Json(null);
}

Json firstHasAnyKey(Json json, string[] keys) {
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.toArray.filterHasAnyKey(keys)) : Json(null);
}

Json firstHasKey(Json json, string key) {
  return json.isArray
    ? uim.phobos.containers.arrays.first.first(json.toArray.filterHasKey(key)) : Json(null);
}
