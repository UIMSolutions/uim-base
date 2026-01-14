/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module datamodel.io.serializers.json_serializer;

import vibe.data.json;
import std.traits;

@safe:

/**
 * JSON serializer interface
 */
interface IJsonSerializer(T) {
  Json serialize(T obj);
  T deserialize(Json json);
}

/**
 * Generic JSON serializer
 */
class JsonSerializer(T) : IJsonSerializer!T {
  Json serialize(T obj) @trusted {
    return serializeToJson(obj);
  }

  T deserialize(Json json) @trusted {
    return deserializeJson!T(json);
  }

  string serializeToString(T obj, bool pretty = false) @trusted {
    auto json = serialize(obj);
    return pretty ? json.toPrettyString() : json.toString();
  }

  T deserializeFromString(string jsonStr) @trusted {
    auto json = parseJsonString(jsonStr);
    return deserialize(json);
  }
}

/**
 * JSON array serializer
 */
class JsonArraySerializer(T) {
  private JsonSerializer!T _itemSerializer;

  this() {
    _itemSerializer = new JsonSerializer!T();
  }

  Json serializeArray(T[] items) @trusted {
    Json[] jsonArray;
    foreach (item; items) {
      jsonArray ~= _itemSerializer.serialize(item);
    }
    return Json(jsonArray);
  }

  T[] deserializeArray(Json json) @trusted {
    T[] result;
    foreach (item; json) {
      result ~= _itemSerializer.deserialize(item);
    }
    return result;
  }

  string serializeArrayToString(T[] items, bool pretty = false) @trusted {
    auto json = serializeArray(items);
    return pretty ? json.toPrettyString() : json.toString();
  }
}