/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.string_;

mixin(Version!("test_uim_vibe"));

import uim.vibe;

@safe:

// #region is
mixin(IsJsonFunctions!("String"));

// #region Json[string]
unittest {
  Json[string] map;
  map["a"] = Json("a");
  map["b"] = Json("b");

  assert(map.isAllString(["a", "b"]));
  assert(map.isAnyString(["a", "b"]));

  map["b"] = Json(8);
  assert(!map.isAllString(["a", "b"]));
  assert(map.isAnyString(["a", "b"]));

  map["a"] = Json(true);
  assert(!map.isAllString(["a", "b"]));
  assert(!map.isAnyString(["a", "b"]));
}
// #endregion Json[string]

// #region Json[]
unittest {
  auto values = [Json("a"), Json("b")];
  assert(values.isAnyString);
  assert(values.isAllString);

  values = [Json("a"), Json(3)];
  assert(values.isAnyString);
  assert(!values.isAllString);

  values = [Json(4), Json(5)];
  assert(!values.isAnyString);
  assert(!values.isAllString);

  assert(isAnyString([Json("a"), Json("b")]));
  assert(isAnyString([Json(7), Json("b")]));

  assert(!isAnyString([Json(7), Json(8)]));
  assert(isAllString([Json("a"), Json("b")]));

  assert(!isAllString([Json(7), Json("b")]));
  assert(!isAllString([Json(7), Json(8)]));
}
// #endregion Json[]

// #region Json
bool isString(Json json, bool strict = true) {
  if (strict) { // strict check for future use
    // TODO: Future use: check if json is a string or a number (int, float)
  }

  return (json.type == Json.Type.string);
}

unittest {
  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": 1.1}], "i": {"j": "x"}}`);
  assert(json.isString("a"));
  assert(!json.isString("c"));
  assert(json.isString(["i", "j"])); // Check path i/j
  assert(!json.isString(["e", "g"])); // Check path e/g

  auto a = Json("a");
  assert(a.isString);
  assert(!a.isInteger);

  auto b = Json("b");
  auto c = Json(1);

  assert([a, b].isAnyString);
  assert([a, c].isAnyString);

  assert([a, b].isAllString);
  assert(![a, c].isAllString);

  auto map = ["A": a, "B": b, "C": c];
  assert(map.isAnyString(["A", "B"]));
  assert(map.isAnyString(["A", "C"]));

  assert(map.isAllString(["A", "B"]));
  assert(!map.isAllString(["A", "C"]));
}
// #endregion Json

unittest {
  assert(parseJsonString(`"a"`).isString);
  assert(!parseJsonString(`1.1`).isString);

  auto json = parseJsonString(`{"a": "b", "c": {"d": 1}, "e": ["f", {"g": 1.1}], "i": {"j": "x"}}`);
  assert(json.isString("a"));
  assert(!json.isString("c"));
  assert(json.isString(["i", "j"]));
  assert(!json.isString(["e", "g"]));
}

unittest {
  assert(!Json(true).isString);
  assert(!Json(10).isString);
  assert(!Json(1.1).isString);
  assert(Json("text").isString);

  Json map = Json.emptyObject;
  map["a"] = Json("a");
  map["b"] = Json("b");
  assert(map.isAllString(["a", "b"]));
  assert(map.isAnyString(["a", "b"]));

  map["b"] = Json(9);
  assert(!map.isAllString(["a", "b"]));
  assert(map.isAnyString(["a", "b"]));

  map["a"] = Json(true);
  assert(!map.isAllString(["a", "b"]));
  assert(!map.isAnyString(["a", "b"]));
}
// #endregion Json

unittest {
  assert(Json("text").isString);
  assert(!Json(10).isString);
  assert(!Json(1.1).isString);
  assert(!Json.emptyObject.isString);
  assert(!Json.emptyArray.isString);
  // assert(!Json.nullValue.isString);

  auto json = parseJsonString(`{"a": "b", "x": "y", "c": {"d": 1}, "e": ["f", {"g": "h"}]}`);
  assert(json.isString("a"));
  assert(!json.isString("c"));

  assert(json.isAllString(["a", "x"]));
  assert(!json.isAllString(["c", "d"]));

  assert(json.isAnyString(["c", "d", "x"]));
  assert(!json.isAnyString(["c", "d", "e"]));
  assert(json.isAnyString(["c", "d", "a"]));
}
// #endregion is

// #region get
mixin(GetJsonValue!("string", "String", "null"));

string getString(Json json) {
  // writeln("getString(Json json, string defaultValue = null): ", json.toString);

  return json.isString
    ? json.get!string : null;
}

unittest {
  Json json = Json("text");
  assert(json.getString == "text");

  json = Json.emptyArray;
  json ~= "a";
  json ~= "b";
  assert(json.getStringAt(0) == "a");
  assert(json.getStringAt(1) == "b");

  json = Json.emptyObject;
  json["a"] = "A";
  json["b"] = "B";
  // writeln(json.toString);
  // writeln(json["a"].toString, " - ", json["a"].length);
  // writeln(" --------------- ");
  // writeln(json["a"].getString, " - ", json.getString("a"), " - ", json.getString("a").length);

  assert(json.getString("a") == "A");
  assert(json.getString("b") == "B");

  auto list = [Json("a"), Json("b")];
  assert(list.getStringAt(0) == "a");
  assert(list.getStringAt(1) != "a");

  auto map = ["A": Json("a"), "B": Json("b")];
  assert(map.getString("A") == "a");
  assert(map.getString("B") != "a");
}
// #endregion get

// #region only
// #endregion only

// #region set  
// #endregion set

// #region remove
// #endregion remove

// #region clear
// #endregion clear

// #region to
// #endregion to

string[] getStringArray(Json[] values) {
  return values
    .filter!(value => value.isString)
    .map!(value => value.get!string)
    .array;
}

string[] toStringArray(Json[] values) {
  return values.map!(value => value.to!string).array;
}
