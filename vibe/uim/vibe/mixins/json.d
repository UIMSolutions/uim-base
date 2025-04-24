/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.mixins.json;

template CheckJsonIs(string jsonType) {
  const char[] CheckJsonIs = `
// #region Json[string]
bool isAll{jsonType}(Json[] values, bool strict = true) {
  return values.all!(value => value.is{jsonType});
}

bool isAll{jsonType}(Json[] values, size_t[] indices, bool strict = true) {
  return indices.all!(index => values.is{jsonType}(index));
}

bool isAny{jsonType}(Json[] values, bool strict = true) {
  return values.any!(value => value.is{jsonType}(strict));
}

bool isAny{jsonType}(Json[] values, size_t[] indices, bool strict = true) {
  return indices.any!(index => values.is{jsonType}(index));
}

bool is{jsonType}(Json[] values, size_t index, bool strict = true) {
  return values.length > index && values[index].is{jsonType}(strict);
}
// #endregion Json[string]

// #region Json[]
bool isAll{jsonType}(Json[] values, bool strict = true) {
  return values.all!(value => value.is{jsonType});
}

bool isAll{jsonType}(Json[] values, size_t[] indices, bool strict = true) {
  return indices.all!(index => values.is{jsonType}(index));
}

bool isAny{jsonType}(Json[] values, bool strict = true) {
  return values.any!(value => value.is{jsonType}(strict));
}

bool isAny{jsonType}(Json[] values, size_t[] indices, bool strict = true) {
  return indices.any!(index => values.is{jsonType}(index));
}

bool is{jsonType}(Json[] values, size_t index, bool strict = true) {
  return values.length > index && values[index].is{jsonType}(strict);
}
// #endregion Json[]
`;
}
