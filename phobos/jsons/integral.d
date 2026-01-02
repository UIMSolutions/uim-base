/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.integral;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region is
bool isIntegral(Json value) {
  return value.isLong;
}
// #endregion is
