module uim.core.convert.uuid;

mixin(Version!("test_uim_core"));

import uim.core;

@safe:

// #region toUUID
UUID toUUID(string key, Json value) {
  return value.isObject
    ? UUID(value.getString(key)) : UUID();
}

UUID toUUID(Json value) {
  return value.isString
    ? UUID(value.getString) : UUID();
}

unittest {
  assert(toUUID(Json()) == UUID());
  assert(toUUID(Json("00000000-0000-0000-0000-000000000000")) == UUID());

  auto id = randomUUID;
  assert(Json(id.toString).toUUID == id);
}
// #endregion toUUID

// #region toJson
Json toJson(string key, UUID value) {
  auto json = Json.emptyObject;
  json[key] = value.toJson;
  return json;
}

Json toJson(UUID value) {
  return value.isNull
    ? Json(UUID().toString)
    : Json(value.toString);
}

unittest {
  auto id = randomUUID;
  assert(id.toJson == Json(id.toString));

  assert(id.toJson("id").getString("id") == id.toString);
}
// #endregion toJson
