/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.json;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region create
// #endregion create

// #region json
mixin(GetJsonValue!("Json", "Json", "Json(null)"));

Json getJson(Json json, Json defaultValue = Json(null)) {
  return json;
}
// #endregion json

// #region update
// #region Json
Json update(Json json, Json map) {
  if (!json.isObject || !map.isObject) {
    return json;
  }

  foreach (key, value; map.byKeyValue) {
    json = json.update(key, value);
  }
  return json;
}

Json update(V)(Json json, V[string] values) {
  if (!json.isObject) {
    return json;
  }

  foreach (key, value; values.byKeyValue) {
    json = json.update(key, value);
  }

  return json;
}

Json update(V)(Json json, string[] keys, V value) {
  if (!json.isObject) {
    return json;
  }

  keys.each!(key => json.update(key, value));
  return json;
}

Json update(V)(Json json, string key, V value) {
  return json.isObject && json.has(key)
    ? json.set(key, value) : json;
}

// TODO
/* unittest {
  auto json = Json.emptyObject;
  json.update("a", "A");
  json.update("b", "B").update("c", "C");
  assert(json.hasAll(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.update("a", Json("A"));
  json.update("b", Json("B")).update("c", Json("C"));
  assert(json.hasAll(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json.update(["a", "b", "c"], "x");
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.update(["a", "b", "c"], Json("x"));
  assert(json.hasAll(["a", "b", "c"]));
  assert(json["a"] == Json("x") && json["b"] == Json("x") && json["c"] == Json("x"));

  json = Json.emptyObject;
  json.update(["a": "A", "b": "B", "c": "C"]);
  assert(json.hasAll(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  json = Json.emptyObject;
  json.update(["a": Json("A"), "b": Json("B"), "c": Json("C")]);
  assert(json.hasAll(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));

  auto newJson = Json.emptyObject;
  newJson.update(json);
  assert(json.hasAll(["a", "b", "c"]));
  assert(json["a"] == Json("A") && json["b"] == Json("B") && json["c"] == Json("C"));
}
 */
// #endregion Json
// #endregion update

// #region merge
// #endregion merge

// #region remove
V[string] remove(V : Json)(V[string] items, string key) {
  if (has(items, key)) {
    items.remove(key);
  }
  return items;
}
// #endregion remove
