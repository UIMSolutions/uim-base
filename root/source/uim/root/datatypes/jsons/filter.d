module uim.root.datatypes.jsons.filter;

import uim.root;

mixin(Version!("test_uim_root"));

@safe:

Json filterValues(Json json, bool delegate(Json json) filterFunc) {
  if (!json.isArray) {
    return Json(null);
  }

  Json result;
  () @trusted {
    result = json.toArray.filter!(value => filterFunc(value)).array.toJson;
  }();
  return result;
}
///
unittest {
  /* auto json = [1, 2, 3, 4, 5].toJson;
  auto filtered = filterValues(json, value => value.asInt % 2 == 0);
  assert(filtered == [2, 4].toJson); */
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
    ? json.toArray.filter!(j => filterFunc(j)).array.toJson : Json(null);
}
///
unittest {
  /* auto json = [1, 2, 3, 4, 5].toJson;
  auto filtered = filterValues(json, value => value.asInt % 2 != 0);
  assert(filtered == [1, 3, 5].toJson); */
}
