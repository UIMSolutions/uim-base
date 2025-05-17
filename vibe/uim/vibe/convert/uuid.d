/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.convert.uuid;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
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
