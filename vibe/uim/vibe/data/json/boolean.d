/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.vibe.data.json.boolean;

mixin(Version!("test_uim_vibe"));

import uim.vibe;
@safe:

// #region is
mixin(CheckJsonIs!("Boolean"));

bool isBoolean(Json value, bool strict = true) {
  if (!strict) {
    if (value.isString) {
      auto val = value.getString.toLower;
      return (val == "false") || (val == "no") || (val == "0") ||
        (val == "true") || (val == "yes") || (val == "1");
    }

    if (value.isLong || value.isInteger) {
      return (value.getLong == 0) || (value.getLong == 1);
    }

    if (value.isDouble) {
      return (value.getDouble == 0.0) && (value.getDouble == 1.0);
    }
  }

  return (value.type == Json.Type.bool_);
}

unittest { // Json
  // strict
  assert(Json(true).isBoolean);
  assert(!Json("text").isBoolean);
  assert(!Json(10).isBoolean);
  assert(!Json(1.1).isBoolean);

  // not strict
  assert(Json(true).isBoolean(false));
  assert(Json("false").isBoolean(false));
  assert(Json("true").isBoolean(false));
  assert(Json("no").isBoolean(false));
  assert(Json("yes").isBoolean(false));
  assert(Json("0").isBoolean(false));
  assert(Json("1").isBoolean(false));
  assert(Json(0).isBoolean(false));
  assert(Json(1).isBoolean(false));
  assert(Json(0.0).isBoolean(false));
  assert(Json(1.0).isBoolean(false));

  Json map = Json.emptyObject;
  map["one"] = Json(1);  
  map["alfa"] = Json("text");
  map["t"] = Json(true);  
  map["f"] = Json(false);
  assert(!map.isBoolean);  
  assert(!map.isBoolean("one"));  
  assert(!map.isBoolean("alfa"));  
  assert(map.isBoolean("t"));  
  assert(map.isBoolean("f"));  

  assert(map.anyBoolean("one", "t"));  
  assert(map.anyBoolean("f", "t"));  
  assert(!map.anyBoolean("one", "alfa"));  

  assert(map.allBoolean("f", "t"));
  assert(!map.allBoolean("f", "alfa"));  
  assert(!map.allBoolean("one", "alfa"));  

  map = Json.emptyObject;
  map["t"] = Json(true);  
  map["f"] = Json(false);
  assert(map.isAllBoolean);

  unittest { // Json[]
  auto a = Json(true);
  auto b = Json(false);
  auto c = Json(1);
  auto d = Json(1.1);
  auto list = [a, b, c, d];
  assert([a, b].isAllBoolean);
  assert(![a, c].isAllBoolean);

  assert(list.isAllBoolean([0, 1]));
  assert(!list.isAllBoolean([2, 3]));

  assert([a, b].isAnyBoolean);
  assert([a, c].isAnyBoolean);
  assert(![c, d].isAnyBoolean);

  assert(list.isAnyBoolean([0, 1]));
  assert(list.isAnyBoolean([1, 2]));
  assert(!list.isAnyBoolean([2, 3]));
}

unittest { // Json[string]
  auto a = Json(true);
  auto b = Json(false);
  auto c = Json(1);
  auto d = Json(1.1);
  auto map = ["A": a, "B": b, "C": c, "D": d];
  assert(["A": a, "B": b].isAllBoolean);
  assert(!["A": a, "C": c].isAllBoolean);

  assert(map.isAllBoolean(["A", "B"]));
  assert(map.isAllBoolean(["A", "C"]));

  assert(["A": a, "B": b].isAnyBoolean);
  assert(["A": a, "C": c].isAnyBoolean);
  assert(!["C": c, "D": d].isAnyBoolean);

  assert(map.isAnyBoolean(["A", "B"]));
  assert(map.isAnyBoolean(["A", "C"]));
  assert(map.isAnyBoolean(["C", "D"]));
}
}
// #endregion is

// #region get 
bool getBoolean(Json value, size_t index) {
  return !value.isNull && value.isArray && value.length > index
    ? value[index].getBoolean : false;
}

bool getBoolean(Json value, string key) {
  return !value.isNull && value.isObject && value.hasKey(key)
    ? value[key].getBoolean : false;
}

bool getBoolean(Json value) {
  return !value.isNull && value.isBoolean
    ? value.get!bool : false;
}

unittest {
  Json jValue = Json(true);

  Json jArray = Json.emptyArray;
  jArray ~= true;
  jArray ~= false;

  Json jObject = Json.emptyObject;
  jObject["true"] = true;
  jObject["false"] = false;

  assert(jValue.getBoolean); // == true
  assert(jArray.getBoolean(0)); // == true
  assert(jObject.getBoolean("true")); // == true
}
// #endregion get

// #region json[]
unittest {
  auto values = [Json(true), Json(false)];
  assert(values.isAllBoolean);

  values = [Json(true), Json(1)];
  assert(!values.isAllBoolean);

  values = [Json(true), Json(false)];
  assert(values.isAnyBoolean);

  values = [Json(true), Json(1)];
  assert(values.isAnyBoolean);

  values = [Json("X"), Json(1)];
  assert(!values.isAnyBoolean);
}
// #endregion json[]

// #region Json[string]
bool isBoolean(Json[string] items, string key) {
  return key in items
    ? items[key].isBoolean 
    : false;
}
// #endregion Json[string]
