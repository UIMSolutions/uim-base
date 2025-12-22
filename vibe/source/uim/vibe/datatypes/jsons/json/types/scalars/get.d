/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.scalars.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

scalar getScalar(Json json, size_t index, string defaultValue = "") {
  return json.isScalar(index) ? json[index].get!(scalar) : defaultValue;
}

scalar getScalar(Json json, scalar key, string defaultValue = "") {
  return json.isScalar(key) ? json[key].get!(scalar) : defaultValue;
}

scalar getScalar(Json value) {
  return value.isScalar  
    ? value.get!(scalar) : "";
}
