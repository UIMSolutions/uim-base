/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.uuids.to_;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

/** 
UUID toUUID(string key, Json json) {
  return json.isObject
    ? UUID(json.getString(key)) : UUID();
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
**/ 