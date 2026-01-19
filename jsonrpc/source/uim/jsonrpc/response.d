/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.jsonrpc.response;

import uim.jsonrpc;

@safe:

/**
 * JSON-RPC 2.0 response.
 */
class DJSONRPCResponse : UIMObject {
  protected string _jsonrpc = "2.0";
  protected Json _result;
  protected DJSONRPCError _error;
  protected Json _id;

  this() {
    super();
    _result = Json(null);
    _id = Json(null);
  }

  this(Json result, Json id) {
    this();
    _result = result;
    _id = id;
  }

  this(DJSONRPCError error, Json id) {
    this();
    _error = error;
    _id = id;
  }

  // Getters
  string jsonrpc() { return _jsonrpc; }
  Json result() { return _result; }
  DJSONRPCError error() { return _error; }
  Json id() { return _id; }

  // Setters
  void result(Json value) { 
    _result = value;
    _error = null;
  }
  
  void error(DJSONRPCError value) { 
    _error = value;
    _result = Json(null);
  }
  
  void id(Json value) { _id = value; }

  /**
   * Check if this is an error response.
   */
  bool isError() {
    return _error !is null;
  }

  /**
   * Check if this is a success response.
   */
  bool isSuccess() {
    return _error is null;
  }

  /**
   * Convert to JSON object.
   */
  Json toJson() {
    auto response = Json.emptyObject;
    response["jsonrpc"] = _jsonrpc;
    
    if (_error !is null) {
      response["error"] = _error.toJson();
    } else {
      response["result"] = _result;
    }
    
    response["id"] = _id;
    
    return response;
  }

  /**
   * Create from JSON object.
   */
  static DJSONRPCResponse fromJson(Json json) {
    auto response = new DJSONRPCResponse();
    
    if (auto jsonrpc = "jsonrpc" in json) {
      if (jsonrpc.get!string != "2.0") {
        throw new Exception("Invalid JSON-RPC version");
      }
    }
    
    if (auto id = "id" in json) {
      response.id = *id;
    }
    
    if (auto error = "error" in json) {
      response.error = DJSONRPCError.fromJson(*error);
    } else if (auto result = "result" in json) {
      response.result = *result;
    }
    
    return response;
  }

  /**
   * Validate the response.
   */
  bool validate() {
    if (_jsonrpc != "2.0") return false;
    
    // Must have either result or error, but not both
    bool hasResult = _result.type != Json.Type.null_;
    bool hasError = _error !is null;
    
    if (hasResult && hasError) return false;
    if (!hasResult && !hasError) return false;
    
    return true;
  }

  override string toString() const {
    if (_error !is null) {
      return "JSON-RPC Error Response: " ~ _error.toString();
    }
    return "JSON-RPC Success Response (id: " ~ _id.toString() ~ ")";
  }
}

// Factory functions
DJSONRPCResponse successResponse(Json result, Json id) {
  return new DJSONRPCResponse(result, id);
}

DJSONRPCResponse successResponse(Json result, long id) {
  return new DJSONRPCResponse(result, Json(id));
}

DJSONRPCResponse successResponse(Json result, string id) {
  return new DJSONRPCResponse(result, Json(id));
}

DJSONRPCResponse errorResponse(DJSONRPCError error, Json id) {
  return new DJSONRPCResponse(error, id);
}

DJSONRPCResponse errorResponse(DJSONRPCError error, long id) {
  return new DJSONRPCResponse(error, Json(id));
}

DJSONRPCResponse errorResponse(DJSONRPCError error, string id) {
  return new DJSONRPCResponse(error, Json(id));
}

unittest {
  auto resp = successResponse(Json(42), 1);
  assert(resp.isSuccess());
  assert(!resp.isError());
  assert(resp.validate());
  
  auto errResp = errorResponse(methodNotFound(), 2);
  assert(errResp.isError());
  assert(!errResp.isSuccess());
}
