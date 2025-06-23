/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.datatypes.json.filter;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

Json[] filterObject (Json[] items) {
  return items.filter!(item => item.isObject).array;
}

Json[] filterNotObject (Json[] items) {
  return items.filter!(item => !item.isObject).array;
}

Json[] filterHasKey (Json[] items, string key) {
  return items.filterObject.filter!(item => item.hasKey(key)).array;
}

Json[] filterWithoutKey (Json[] items, string key) {
  return items.filterObject.filter!(item => !item.hasKey(key)).array;
}
