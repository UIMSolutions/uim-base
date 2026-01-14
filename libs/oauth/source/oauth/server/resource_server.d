/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module oauth.server.resource_server;

import oauth.tokens.access_token;
import vibe.http.server;
import vibe.http.status;

@safe:

/**
 * Resource server - validates access tokens
 */
class ResourceServer {
  private bool delegate(string token) @safe _validateToken;

  this(bool delegate(string token) @safe validateToken) {
    _validateToken = validateToken;
  }

  /**
   * Middleware to protect routes
   */
  void protectRoute(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    auto authHeader = "Authorization" in req.headers;
    
    if (!authHeader) {
      res.statusCode = HTTPStatus.unauthorized;
      res.writeJsonBody(["error": "Missing authorization header"]);
      return;
    }

    import std.string : split, strip;
    auto parts = authHeader.strip().split(" ");
    
    if (parts.length != 2 || parts[0] != "Bearer") {
      res.statusCode = HTTPStatus.unauthorized;
      res.writeJsonBody(["error": "Invalid authorization header format"]);
      return;
    }

    auto token = parts[1];
    
    if (!_validateToken(token)) {
      res.statusCode = HTTPStatus.unauthorized;
      res.writeJsonBody(["error": "Invalid or expired token"]);
      return;
    }
  }
}