/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.booleans.isboolean;

import uim.vibe;

mixin(Version!("test_uim_vibe"));
@safe:





bool isAnyBoolean(Json json) {
  if (json.isArray) {
    return json.toArray.isAnyBoolean;
  }

  if (json.isObject) {
    return json.toMap.isAnyBoolean;
  }

  return json.isBoolean;
}
/** 
  * Checks if all elements in the array are of boolean type.
  *
  * Params:
  *   values = The array to check.
  *
  * Returns:
  *   `true` if all elements are booleans, `false` otherwise.
  */

