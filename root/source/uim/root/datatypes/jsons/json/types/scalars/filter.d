/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.scalars.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json filterScalars(Json json, bool delegate(Json json) @safe filterFunc) {
  if (json.isArray) {
    auto result = Json.emptyArray;
    foreach (value; json.ByValue) {
      if (value.isScalar && filterFunc(value)) {
        result.values ~= value;
      }
    }
    return result;
  }
  if (json.isObject) {
    auto result = Json.emptyObject;
    foreach (key, value; json.ByKeyValue) {
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
    foreach (index, value; json.ByValue) {
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
    foreach (value; json.ByValue) {
      if (value.isScalar) {
        result.values ~= value;
      }
    }
    return result;
  }
  if (json.isObject) {
    auto result = Json.emptyObject;
    foreach (key, value; json.ByKeyValue) {
      if (value.isScalar) {
        result[key] = value;
      }
    }
    return result;
  }

  return json.isScalar ? json : Json(null);
}
