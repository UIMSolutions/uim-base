/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.strings.get;

import uim.root;

mixin(Version!("show_uim_root"));

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
