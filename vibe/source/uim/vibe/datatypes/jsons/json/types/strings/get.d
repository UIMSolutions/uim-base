module uim.vibe.datatypes.jsons.json.types.strings.get;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

// #region get
string getString(Json json, size_t index, string defaultValue = "") {
  return json.isString(index) ? json[index].get!(string) : defaultValue;
}

string getString(Json json, string key, string defaultValue = "") {
  return json.isString(key) ? json[key].get!(string) : defaultValue;
}

string getString(Json json, string defaultValue = "") {
  return json.isString ? json.get!(string) : defaultValue;
}
// #endregion get