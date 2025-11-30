/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.objects.object_;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:




// #region get
Json[string] getObject(Json json) {
  return json.isObject
    ? json.to!(Json[string])
    : null;
}
// #endregion get

// #region only
// #endregion only

// #region to
// #endregion to