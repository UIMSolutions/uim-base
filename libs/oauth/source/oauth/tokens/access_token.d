/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module oauth.tokens.access_token;

import std.datetime;
import vibe.data.json;

@safe:

/**
 * OAuth access token
 */
class AccessToken {
  private string _accessToken;
  private string _tokenType;
  private string _refreshToken;
  private long _expiresIn;
  private string[] _scopes;
  private SysTime _issuedAt;

  this(string accessToken, string tokenType, long expiresIn, string refreshToken = "", string[] scopes = []) {
    _accessToken = accessToken;
    _tokenType = tokenType;
    _expiresIn = expiresIn;
    _refreshToken = refreshToken;
    _scopes = scopes;
    _issuedAt = Clock.currTime();
  }

  string accessToken() const { return _accessToken; }
  string tokenType() const { return _tokenType; }
  string refreshToken() const { return _refreshToken; }
  long expiresIn() const { return _expiresIn; }
  string[] scopes() const { return _scopes.dup; }
  SysTime issuedAt() const { return _issuedAt; }

  bool isExpired() const {
    if (_expiresIn <= 0) return false;
    auto now = Clock.currTime();
    auto expiryTime = _issuedAt + dur!"seconds"(_expiresIn);
    return now >= expiryTime;
  }

  bool hasRefreshToken() const {
    return _refreshToken.length > 0;
  }

  bool hasScope(string scope_) const {
    import std.algorithm : canFind;
    return _scopes.canFind(scope_);
  }

  Json toJson() const @trusted {
    Json json = Json.emptyObject;
    json["access_token"] = _accessToken;
    json["token_type"] = _tokenType;
    json["expires_in"] = _expiresIn;
    if (_refreshToken.length > 0) {
      json["refresh_token"] = _refreshToken;
    }
    if (_scopes.length > 0) {
      json["scope"] = Json(_scopes);
    }
    return json;
  }

  static AccessToken fromJson(Json json) @trusted {
    auto accessToken = json["access_token"].get!string;
    auto tokenType = json["token_type"].get!string;
    auto expiresIn = json["expires_in"].get!long;
    
    string refreshToken;
    if (auto rt = "refresh_token" in json) {
      refreshToken = rt.get!string;
    }

    string[] scopes;
    if (auto s = "scope" in json) {
      if (s.type == Json.Type.string) {
        import std.string : split;
        scopes = s.get!string.split(" ");
      } else if (s.type == Json.Type.array) {
        foreach (scope_; *s) {
          scopes ~= scope_.get!string;
        }
      }
    }

    return new AccessToken(accessToken, tokenType, expiresIn, refreshToken, scopes);
  }

  string getAuthorizationHeader() const {
    return _tokenType ~ " " ~ _accessToken;
  }
}