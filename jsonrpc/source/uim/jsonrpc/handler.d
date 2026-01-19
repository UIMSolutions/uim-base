/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.jsonrpc.handler;

import uim.jsonrpc;

@safe:

/**
 * Method handler delegate type.
 */
alias JSONRPCHandler = Json delegate(Json params) @safe;

/**
 * Method handler registry.
 */
class DJSONRPCHandlerRegistry : UIMObject {
  protected JSONRPCHandler[string] _handlers;

  this() {
    super();
  }

  /**
   * Register a method handler.
   */
  void register(string methodName, JSONRPCHandler handler) {
    _handlers[methodName] = handler;
  }

  /**
   * Check if a method is registered.
   */
  bool has(string methodName) {
    return (methodName in _handlers) !is null;
  }

  /**
   * Get a method handler.
   */
  JSONRPCHandler get(string methodName) {
    if (auto handler = methodName in _handlers) {
      return *handler;
    }
    return null;
  }

  /**
   * Unregister a method handler.
   */
  bool unregister(string methodName) {
    if (methodName in _handlers) {
      _handlers.remove(methodName);
      return true;
    }
    return false;
  }

  /**
   * Get all registered method names.
   */
  string[] methods() {
    return _handlers.keys;
  }

  /**
   * Clear all handlers.
   */
  void clear() {
    _handlers.clear();
  }
}

unittest {
  auto registry = new DJSONRPCHandlerRegistry();
  
  registry.register("add", (Json params) {
    auto arr = params.get!(Json[]);
    return Json(arr[0].get!long + arr[1].get!long);
  });
  
  assert(registry.has("add"));
  assert(!registry.has("subtract"));
  
  auto handler = registry.get("add");
  assert(handler !is null);
}
