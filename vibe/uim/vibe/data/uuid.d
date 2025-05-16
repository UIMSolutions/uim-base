/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.uuid;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region toJson
Json toJson(string key, UUID value) {
  auto json = Json.emptyObject;
  json[key] = value.toJson;
  return json;
}

Json toJson(UUID value) {
  return Json(UUID().toString);
}

unittest {
  auto id = randomUUID;
  assert(id.toJson == Json(id.toString));

  assert(id.toJson("id").getString("id") == id.toString);
}
