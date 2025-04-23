/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.string_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
// #endregion is

// #region get
string getString(Json value, string key) {
  return value.isObject && value.hasKey(key)
    ? value[key].getString : null;
}

string getString(Json value) {
  return value.isString
    ? value.get!string : null;
}
// #endregion get

// #region only
// #endregion only
