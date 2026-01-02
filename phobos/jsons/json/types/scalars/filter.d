/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.json.types.scalars.filter;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

Json filterScalars(Json json, bool delegate(Json json) @safe filterFunc) {
  if (json.isArray) {
    auto result = Json.emptyArray;
    foreach (value; json.byValue) {
      if (value.isScalar && filterFunc(value)) {
        result ~= value;
      }
    }
    return result;
  }
  if (json.isObject) {
    auto result = Json.emptyObject;
    foreach (key, value; json.byKeyValue) {
      if (value.isScalar && filterFunc(value)) {
        result[key] = value;
      }
    }
    return result;
  }

  return json.isScalar && filterFunc(json) ? json : Json(null);
}

Json filterScalars(Json json, size_t[] indices) {
  if (json.isArray) {
    auto result = Json.emptyArray;
    foreach (index, value; json.byValue) {
      if (value.isScalar && indices.hasValue(index)) {
        result.values ~= value;
      }
    }
    return result;
  }

  return json;
}

Json filterScalars(Json json) {
  if (json.isArray) {
    auto result = Json.emptyArray;
    foreach (value; json.byValue) {
      if (value.isScalar) {
        result.values ~= value;
      }
    }
    return result;
  }
  if (json.isObject) {
    auto result = Json.emptyObject;
    foreach (key, value; json.byKeyValue) {
      if (value.isScalar) {
        result[key] = value;
      }
    }
    return result;
  }

  return json.isScalar ? json : Json(null);
}
