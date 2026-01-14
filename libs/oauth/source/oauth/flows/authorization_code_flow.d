/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module oauth.flows.authorization_code_flow;

import oauth.client.oauth_client;
import oauth.tokens.access_token;
import oauth.tokens.token_storage;
import vibe.http.server;
import vibe.http.router;

@safe:

/**
 * Authorization Code Flow helper
 */
class AuthorizationCodeFlow {
  private OAuthClient _client;
  private ITokenStorage _storage;
  private string _state;

  this(OAuthClient client, ITokenStorage storage = null) {
    _client = client;
    _storage = storage ? storage : new InMemoryTokenStorage();
  }

  /**
   * Start authorization flow
   */
  string startFlow(string identifier) @trusted {
    import std.digest.sha : sha256Of;
    import std.digest : toHexString;
    import std.uuid : randomUUID;
    
    _state = randomUUID().toString();
    return _client.getAuthorizationUrl(_state);
  }

  /**
   * Handle callback
   */
  AccessToken handleCallback(string code, string state, string identifier) @trusted {
    if (state != _state) {
      throw new Exception("State mismatch");
    }

    auto token = _client.exchangeCode(code, state);
    _storage.store(identifier, token);
    return token;
  }

  /**
   * Get stored token
   */
  AccessToken getToken(string identifier) {
    auto token = _storage.retrieve(identifier);
    
    if (token && token.isExpired() && token.hasRefreshToken()) {
      token = _client.refreshToken(token.refreshToken());
      _storage.store(identifier, token);
    }
    
    return token;
  }

  /**
   * Register callback route
   */
  void registerCallbackRoute(URLRouter router, string callbackPath, 
                            void delegate(HTTPServerRequest, HTTPServerResponse, AccessToken) @safe onSuccess) @trusted {
    router.get(callbackPath, (req, res) @trusted {
      auto code = req.query.get("code", "");
      auto state = req.query.get("state", "");
      auto error = req.query.get("error", "");

      if (error.length > 0) {
        res.writeBody("Authorization failed: " ~ error);
        return;
      }

      if (code.length == 0) {
        res.writeBody("Missing authorization code");
        return;
      }

      try {
        // Use session ID or user ID as identifier
        auto identifier = req.session ? req.session.id : "default";
        auto token = handleCallback(code, state, identifier);
        onSuccess(req, res, token);
      } catch (Exception e) {
        res.writeBody("Error: " ~ e.msg);
      }
    });
  }
}