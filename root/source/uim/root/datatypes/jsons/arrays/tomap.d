module uim.root.convert.tomap;

import uim.root;

mixin(Version!("test_uim_root"));
@safe:

/**
  * Converts a JSON object to a D associative array (map).
  *
  * If the provided JSON is not of type object, the function returns null.
  *
  * Params:
  *   json = The JSON object to convert.
  *
  * Returns:
  *   A D associative array (map) if the JSON is an object; otherwise, null.
  */
Json[string] toMap(Json json) {
  return json.type == Json.Type.object
    ? json.get!(Json[string]) : null;
}
///
unittest {
  // Test: valid JSON object
  Json obj = Json.emptyObject;
  obj["a"] = Json(1);
  obj["b"] = Json("test");

  auto map = obj.toMap;
  assert(map !is null, "Expected non-null map for JSON object");
  assert(map["a"].isInteger);
  assert(map["b"].isString);

  // Test: JSON array
  Json arr = Json([Json(1), Json(2)]);
  auto mapArr = toMap(arr);
  assert(mapArr is null, "Expected null for JSON array");

  // Test: JSON string
  Json str = Json("hello");
  auto mapStr = toMap(str);
  assert(mapStr is null, "Expected null for JSON string");

  // Test: JSON integer
  Json num = Json(42);
  auto mapNum = toMap(num);
  assert(mapNum is null, "Expected null for JSON integer");

  // Test: JSON null
  Json nullJson = Json();
  auto mapNull = toMap(nullJson);
  assert(mapNull is null, "Expected null for JSON null");
}
