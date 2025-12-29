module uim.root.datatypes.jsons.helper;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json filterArrays(Json json) {
  import uim.root.datatypes.jsons.arrays.filter;
  if (json.isArray) {
    return filterValues(json.get!(Json[], (Json json) => json.isArray)).toJson;
  } 
  /* 
  if (json.isObject) {
    return filterMap(json.toMap).toJson;
  }
  */
  return Json(null);
}

