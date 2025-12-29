/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.strings.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

string getString(Json json, size_t index, string defaultValue = "") {
  return json.isString(index) ? json[index].get!(string) : defaultValue;
}

string getString(Json json, string key, string defaultValue = "") {
  return json.isString(key) ? json[key].get!(string) : defaultValue;
}

string getString(Json value) {
  return value.isString  
    ? value.get!(string) : "";
}
