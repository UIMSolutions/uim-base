/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.mixins.json;

template CheckJsonIs(string jsonType) {
  const char[] CheckJsonIs = `
// Json[]

bool all`~jsonType~`(Json[] values) {
  return values.all!(value => value.is`~jsonType~`);
}

bool any`~jsonType~`(Json[] values) {
  return values.any!(value => value.is`~jsonType~`);
}

// Json
bool all`~jsonType~`(Json value, string[] keys) {
  return keys.all!(key => value.is`~jsonType~`(key));
}

bool any`~jsonType~`(Json value, string[] keys) {
  return keys.any!(key => value.is`~jsonType~`(key));
}
`;
}
