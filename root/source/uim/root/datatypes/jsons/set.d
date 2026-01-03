/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.jsons.set;

import uim.root;

mixin(Version!("show_uim_root"));

@safe:

/// Sets multiple keys to values from a map
Json setValues(Json json, Json[string] map) {
  auto result = json;
  foreach (kv; map.byKeyValue) {
    result.setValue(kv.key, kv.value);
  }
  return result;
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing setValues with map");

}

/// Sets multiple keys to the same value
Json setValues(Json json, string[] keys, Json value) {
  keys.each!(key => json.setValue(key, value));
  return json;
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing setValues with keys and value");

}

/// Set path with value
Json setValue(Json json, string[] path, Json value) {
  if (!json.isObject || path.length == 0) {
    return json;
  }

  if (path.length == 1) {
    return json.setValue(path[0], value);
  }

  if (json.hasKey(path[0])) {
    json[path[0]] = json[path[0]].setValue(path[1 .. $], value);
  } else {
    Json child = Json.emptyObject;
    child = child.setValue(path[1 .. $], value);
    json[path[0]] = child;
  }
  
  return json;
}
/// 
unittest {
}

/// Sets a single key to a value
Json setValue(Json json, string key, Json value) {
  if (json.isObject) {
    json[key] = value;
  }
  return json;
}
/// 
unittest {
  version (show_uim_root)
    writeln("Testing setValue with key and value");

  auto json = Json.emptyObject;
  json = json.setValue("name", Json("example"));
  assert(json["name"] == Json("example"));
}
