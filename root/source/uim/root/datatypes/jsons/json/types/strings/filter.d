/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.vibe.datatypes.jsons.json.types.strings.filter;

import uim.vibe;

mixin(Version!("test_uim_vibe"));

@safe:

Json filterStrings(Json json, bool delegate(Json json) @safe filterFunc) {
  if (json.isArray) {
    return json.toArray.filter!(j => foundFilterString(j, filterFunc)).array.toJson;
  }
  if (json.isObject) {
    auto result = Json.emptyObject;
    foreach(k, v; json.toMap) {
      if (foundFilterString(v, filterFunc)) {
        return result[k] = v;
      }
    }
    return result;
  }
  return foundFilterString(json, filterFunc) ? json : Json(null);
}

Json filterStrings(Json jsons, size_t[] indices) {
  return json.isArray ? json.toArray.filterValues(indices).toJson : Json(null);
}

Json filterStrings(Json json) {
  if (json.isArray) {
    return json.toArray.filter!(j => j.isSString).array.toJson;
  }
  if (json.isObject) {
    auto result = Json.emptyObject;
    foreach(k, v; json.toMap) {
      if (v.isSString) {
        return result[k] = v;
      }
    }
    return result;
  }
  return json.isString ? json : Json(null);
}

protected bool foundFilterString(Json json, bool delegate(Json value) @safe filterFunc) {
  return json.isString && filterFunc(json);
}