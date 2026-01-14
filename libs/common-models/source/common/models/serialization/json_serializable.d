/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.serialization.json_serializable;

import vibe.data.json;

@safe:

/**
 * Interface for JSON serializable entities
 */
interface IJsonSerializable {
  Json toJson() const;
  void fromJson(Json json);
}

/**
 * Helper struct for JSON conversion
 */
struct JsonConverter {
  static Json toJson(T)(T value) @trusted {
    return serializeToJson(value);
  }

  static T fromJson(T)(Json json) @trusted {
    return deserializeJson!T(json);
  }
}