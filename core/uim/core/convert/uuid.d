module uim.core.convert.uuid;

mixin(Version!("test_uim_core"));

import uim.core;

@safe:

// #region Json
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
// #endregion Json
