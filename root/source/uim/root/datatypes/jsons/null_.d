/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.null_;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

// #region Null
/// Create a null Json value for the specified type.
T Null(T : Json[string])() {
  return null;
}

/// Create a null Json array value.
T Null(T : Json[])() {
  return null;
}

/// Create a null Json value.
T Null(T : Json)() if (is(T == Json)) {
  return Json(null);
}
// #endregion Null