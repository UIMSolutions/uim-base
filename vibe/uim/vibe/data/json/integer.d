module uim.vibe.data.json.integer;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region isInteger
mixin(CheckJsonIs!("Integer"));

bool isInteger(Json value, string key) {
  return value.hasKey(key)
    ? value[key].isInteger : false;
}

bool isInteger(Json value) {
  return (value.type == Json.Type.int_);
}

unittest {
  assert(!Json(true).isInteger);
  assert(Json(10).isInteger);
  assert(!Json(1.1).isInteger);
  assert(!Json("text").isInteger);

  Json map = Json.emptyObject;
  map["a"] = Json(1);
  map["b"] = Json(2);
  map["c"] = Json(3.0);

  assert(map.isInteger("a") && map.isInteger("b"));
  assert(!map.isInteger("c"));

  assert(map.allInteger("a", "b"));
  assert(map.allInteger(["a", "b"]));

  assert(map.anyInteger("a", "b"));
  assert(map.anyInteger(["a", "b"]));

  map["b"] = Json("B");
  assert(map.isInteger("a"));
  assert(!map.isInteger("b") && !map.isInteger("c"));

  assert(!map.allInteger("a", "b"));
  assert(!map.allInteger(["a", "b"]));

  assert(map.anyInteger("a", "b"));
  assert(map.anyInteger(["a", "b"]));

  map["a"] = Json("A");
  assert(!map.isInteger("a") && !map.isInteger("b") && !map.isInteger("c"));

  assert(!map.allInteger("a", "b"));
  assert(!map.allInteger(["a", "b"]));

  assert(!map.anyInteger("a", "b"));
  assert(!map.anyInteger(["a", "b"]));

  // Json[]
  auto a = Json(1);
  auto b = Json(2);
  assert(a.isInteger("a") && b.isInteger("b"));

  assert(map.allInteger(a, b));
  assert(map.allInteger([a, b]));

  assert(map.anyInteger(a, b));
  assert(map.anyInteger([a, b]));

  b = Json(2.0);
  assert(a.isInteger("a") && !b.isInteger("b"));

  assert(!map.allInteger(a, b));
  assert(!map.allInteger([a, b]));

  assert(map.anyInteger(a, b));
  assert(map.anyInteger([a, b]));

  a = Json(1.0);
  assert(!a.isInteger("a") && !b.isInteger("b"));

  assert(!map.allInteger(a, b));
  assert(!map.allInteger([a, b]));

  assert(!map.anyInteger(a, b));
  assert(!map.anyInteger([a, b]));
}
// #endregion isInteger

// #region get
// #endregion get

// #region only
// #endregion only