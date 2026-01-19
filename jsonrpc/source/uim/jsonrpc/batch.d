/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.jsonrpc.batch;

import uim.jsonrpc;

@safe:

/**
 * JSON-RPC 2.0 batch request.
 */
class DJSONRPCBatchRequest : UIMObject {
  protected DJSONRPCRequest[] _requests;

  this() {
    super();
  }

  this(DJSONRPCRequest[] requests) {
    this();
    _requests = requests;
  }

  // Getters
  DJSONRPCRequest[] requests() { return _requests.dup; }

  /**
   * Add a request to the batch.
   */
  void add(DJSONRPCRequest request) {
    _requests ~= request;
  }

  /**
   * Get number of requests in batch.
   */
  size_t count() {
    return _requests.length;
  }

  /**
   * Check if batch is empty.
   */
  bool isEmpty() {
    return _requests.length == 0;
  }

  /**
   * Convert to JSON array.
   */
  Json toJson() {
    Json[] jsonArray;
    foreach (request; _requests) {
      jsonArray ~= request.toJson();
    }
    return Json(jsonArray);
  }

  /**
   * Create from JSON array.
   */
  static DJSONRPCBatchRequest fromJson(Json json) {
    auto batch = new DJSONRPCBatchRequest();
    
    if (json.type != Json.Type.array) {
      throw new Exception("Batch request must be an array");
    }
    
    foreach (item; json.get!(Json[])) {
      batch.add(DJSONRPCRequest.fromJson(item));
    }
    
    return batch;
  }
}

/**
 * JSON-RPC 2.0 batch response.
 */
class DJSONRPCBatchResponse : UIMObject {
  protected DJSONRPCResponse[] _responses;

  this() {
    super();
  }

  this(DJSONRPCResponse[] responses) {
    this();
    _responses = responses;
  }

  // Getters
  DJSONRPCResponse[] responses() { return _responses.dup; }

  /**
   * Add a response to the batch.
   */
  void add(DJSONRPCResponse response) {
    _responses ~= response;
  }

  /**
   * Get number of responses in batch.
   */
  size_t count() {
    return _responses.length;
  }

  /**
   * Check if batch is empty.
   */
  bool isEmpty() {
    return _responses.length == 0;
  }

  /**
   * Convert to JSON array.
   */
  Json toJson() {
    Json[] jsonArray;
    foreach (response; _responses) {
      jsonArray ~= response.toJson();
    }
    return Json(jsonArray);
  }

  /**
   * Create from JSON array.
   */
  static DJSONRPCBatchResponse fromJson(Json json) {
    auto batch = new DJSONRPCBatchResponse();
    
    if (json.type != Json.Type.array) {
      throw new Exception("Batch response must be an array");
    }
    
    foreach (item; json.get!(Json[])) {
      batch.add(DJSONRPCResponse.fromJson(item));
    }
    
    return batch;
  }
}

unittest {
  auto batch = new DJSONRPCBatchRequest();
  batch.add(request("method1", Json(null), 1));
  batch.add(request("method2", Json(null), 2));
  
  assert(batch.count() == 2);
  assert(!batch.isEmpty());
  
  auto json = batch.toJson();
  assert(json.type == Json.Type.array);
  assert(json.get!(Json[]).length == 2);
}
