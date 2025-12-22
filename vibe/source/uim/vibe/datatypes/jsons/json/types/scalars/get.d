/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.scalars.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json getScalarByIndex(Json json, size_t index, Json defaultValue = Json(null)) {
  return json.isScalar(index) ? json[index] : defaultValue;
}

Json getScalarByKey(Json json, string key, Json defaultValue = Json(null)) {
  return json.isScalar(key) ? json[key] : defaultValue;
}

Json getScalar(Json json, Json defaultValue = Json(null)) {
  return json.isScalar  
    ? json : defaultValue;
}
