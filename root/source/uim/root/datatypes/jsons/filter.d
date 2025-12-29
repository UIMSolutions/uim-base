module uim.root.datatypes.jsons.filter;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json filterValues(Json json, bool delegate(Json json) filterFunc) {
  if (!json.isArray) {
    return Json(null);
  }

  Json[] results;
  () @trusted { results = json.toArray.filter!(value => filterFunc(value)).array; }();
  return results.toJson;
}

/** 
  Filters the values of a JSON array based on a provided filter function.

  Params:
    json = The input JSON which is expected to be an array.
    filterFunc = A delegate function that takes a JSON value and returns a boolean indicating whether to include it.

  Returns:
    A new JSON array containing only the values for which the filter function returned true.
    If the input JSON is not an array, returns a JSON null.
*/
Json filterValues(Json json, bool delegate(Json json) @safe filterFunc) {
  return json.isArray 
    ? json.toArray.filter!(j => filterFunc(j)).array.toJson
    : Json(null);
}
