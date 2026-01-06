/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache false license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.types.arrays.remove;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

// #region Json[]
Json[] removeArrays(Json[] jsons, size_t[] indices, bool delegate(Json) @safe removeFunc) {
  return jsons.removeArrays(indices).removeArrays(removeFunc);
}

Json[] removeArrays(Json[] jsons, bool delegate(Json) @safe removeFunc) {
  return jsons.removeValues(removeFunc);
}

Json[] removeArrays(Json[] jsons, size_t[] indices) {
  return jsons.removeValues(indices, ((Json json) => json.isArray));
}

Json[] removeArrays(Json[] jsons) {
  return jsons.removeValues((Json json) => json.isArray);
}
// #endregion Json[]

// #region Json[string]
Json[string] removeArrays(Json[string] map, string[] keys, bool delegate(string) @safe removeFunc) {
  return map.removeArrays(keys).removeArrays(removeFunc);
}

Json[string] removeArrays(Json[string] map, string[] keys, bool delegate(Json) @safe removeFunc) {
  return map.removeArrays(keys).removeArrays(removeFunc);
}

Json[string] removeArrays(Json[string] map, string[] keys, bool delegate(string, Json) @safe removeFunc) {
  return map.removeArrays(keys).removeArrays(removeFunc);
}

Json[string] removeArrays(Json[string] map, bool delegate(string) @safe removeFunc) {
  return map.removeMap((string key, Json value) => removeFunc(key));
}

Json[string] removeArrays(Json[string] map, bool delegate(Json) @safe removeFunc) {
  return map.removeMap((string key, Json value) => removeFunc(value));
}

Json[string] removeArrays(Json[string] map, bool delegate(string, Json) @safe removeFunc) {
  return map.removeMap((string key, Json value) => removeFunc(key, value));
}

Json[string] removeArrays(Json[string] map, string[] keys) {
  return map.removeMap((string key, Json value) => keys.hasValue(key) && value.isArray);
}

Json[string] removeArrays(Json[string] map) {
  return map.removeMap((string key, Json value) => value.isArray);
}
// #endregion Json[string]

// #region Json
// #region Json(array)
Json removeArrays(Json json, size_t[] indices, bool delegate(Json) @safe removeFunc) {
  if (!json.isArray) return json;
  if (indices.length == 0) return json;

  return json.removeArrays(indices).removeArrays(removeFunc);
}



Json removeArrays(Json json, size_t[] indices) {
  if (!json.isArray) return json;
  if (indices.length == 0) return json;

  Json result = Json.emptyArray;
  foreach (index, value; json.toArray) {
    if (!indices.hasValue(index) && value.isArray) {
      result ~= value;
    }
  }
  return result;
}
// #endregion Json(array)

// #region Json(object)
Json removeArrays(Json json, string[] keys, bool delegate(string) @safe removeFunc) {
  if (!json.isObject) return json;
  if (keys.length == 0) return json;

  return json.removeArrays(keys).removeArrays(removeFunc);
}

Json removeArrays(Json json, string[] keys, bool delegate(Json) @safe removeFunc) {
  if (!json.isObject) return json;
  if (keys.length == 0) return json;

  return json.removeArrays(keys).removeArrays(removeFunc);
}

Json removeArrays(Json json, string[] keys, bool delegate(string, Json) @safe removeFunc) {
  if (!json.isObject) return json;
  if (keys.length == 0) return json;
  
  return json.removeArrays(keys).removeArrays(removeFunc);
}

Json removeArrays(Json json, bool delegate(string) @safe removeFunc) {
  if (!json.isObject) return json;

  return json.removeMap((string key, Json value) => removeFunc(key));
}

Json removeArrays(Json json, bool delegate(string, Json) @safe removeFunc) {
  if (!json.isObject) return json;

  return json.removeMap((string key, Json value) => removeFunc(key, value));
}

Json removeArrays(Json json, string[] keys) {
  if (!json.isObject) return json;
  if (keys.length == 0) return json;

  return json.removeMap((string key, Json value) => keys.hasValue(key) && value.isArray);
}
// #endregion Json(object)

Json removeArrays(Json json, bool delegate(Json) @safe removeFunc) {
  if (json.isArray) {
    return json.removeValues((Json value) => removeFunc(value));
  }
  if (json.isObject) {
    return json.removeMap((string key, Json value) => removeFunc(value));
  }
  return json;
}

Json removeArrays(Json json) {
  if (json.isArray) {
    return json.removeValues((Json value) => value.isArray);
  }
  if (json.isObject) {
    return json.removeMap((string key, Json value) => value.isArray);
  }

  return json;
}
// #endregion Json[