/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module oauth.client.oauth_client;

import oauth.core.config;
import oauth.core.exceptions;
import oauth.tokens.access_token;
import vibe.http.client;
import vibe.data.json;
import std.uri;
import std.string;
import std.algorithm;

@safe:

/**
 * OAuth 2.0 client
 */
class OAuthClient {
  private OAuthConfig _config;

  this(OAuthConfig config) {
    _config = config;
  }

  /**
   * Generate authorization URL
   */
  string getAuthorizationUrl(string state = "") @trusted {
    import std.digest.sha : sha256Of;
    import std.digest : toHexString;
    import std.random : uniform;
    
    if (state.length == 0) {
      // Generate random state for CSRF protection
      auto randomData = uniform!ulong();
      state = toHexString(sha256Of(randomData.to!string)).idup;
    }

    string[string] params;
    params["response_type"] = "code";
    params["client_id"] = _config.clientId;
    params["redirect_uri"] = _config.redirectUri;
    params["state"] = state;
    
    if (_config.scopes.length > 0) {
      params["scope"] = _config.scopes.join(" ");
    }

    auto queryString = buildQueryString(params);
    return _config.authorizationEndpoint ~ "?" ~ queryString;
  }

  /**
   * Exchange authorization code for access token
   */
  AccessToken exchangeCode(string code, string state = "") @trusted {
    if (_config.state.length > 0 && state != _config.state) {
      throw new InvalidStateException("State mismatch");
    }

    string[string] params;
    params["grant_type"] = GrantType.AuthorizationCode;
    params["code"] = code;
    params["redirect_uri"] = _config.redirectUri;
    params["client_id"] = _config.clientId;
    params["client_secret"] = _config.clientSecret;

    return requestToken(params);
  }

  /**
   * Refresh access token
   */
  AccessToken refreshToken(string refreshToken) @trusted {
    string[string] params;
    params["grant_type"] = GrantType.RefreshToken;
    params["refresh_token"] = refreshToken;
    params["client_id"] = _config.clientId;
    params["client_secret"] = _config.clientSecret;

    return requestToken(params);
  }

  /**
   * Get access token using client credentials
   */
  AccessToken getClientCredentialsToken() @trusted {
    string[string] params;
    params["grant_type"] = GrantType.ClientCredentials;
    params["client_id"] = _config.clientId;
    params["client_secret"] = _config.clientSecret;
    
    if (_config.scopes.length > 0) {
      params["scope"] = _config.scopes.join(" ");
    }

    return requestToken(params);
  }

  /**
   * Get access token using resource owner password credentials
   */
  AccessToken getPasswordToken(string username, string password) @trusted {
    string[string] params;
    params["grant_type"] = GrantType.Password;
    params["username"] = username;
    params["password"] = password;
    params["client_id"] = _config.clientId;
    params["client_secret"] = _config.clientSecret;
    
    if (_config.scopes.length > 0) {
      params["scope"] = _config.scopes.join(" ");
    }

    return requestToken(params);
  }

  /**
   * Make authenticated API request
   */
  Json makeRequest(string url, AccessToken token, HTTPMethod method = HTTPMethod.GET) @trusted {
    return requestHTTP(url,
      (scope req) {
        req.method = method;
        req.headers["Authorization"] = token.getAuthorizationHeader();
        req.headers["Accept"] = "application/json";
      },
      (scope res) {
        auto body_ = res.bodyReader.readAllUTF8();
        return parseJsonString(body_);
      }
    );
  }

  /**
   * Get user info
   */
  Json getUserInfo(AccessToken token) @trusted {
    if (_config.userInfoEndpoint.length == 0) {
      throw new OAuthException("User info endpoint not configured");
    }
    return makeRequest(_config.userInfoEndpoint, token);
  }

  private AccessToken requestToken(string[string] params) @trusted {
    auto body_ = buildQueryString(params);
    
    Json response = requestHTTP(_config.tokenEndpoint,
      (scope req) {
        req.method = HTTPMethod.POST;
        req.headers["Content-Type"] = "application/x-www-form-urlencoded";
        req.headers["Accept"] = "application/json";
        req.writeBody(cast(ubyte[])body_);
      },
      (scope res) {
        if (res.statusCode != 200) {
          throw new TokenException("Token request failed with status " ~ res.statusCode.to!string);
        }
        auto responseBody = res.bodyReader.readAllUTF8();
        return parseJsonString(responseBody);
      }
    );

    // Check for errors
    if ("error" in response) {
      throw new AuthorizationException(
        response["error"].get!string,
        response.get("error_description", "Unknown error").get!string
      );
    }

    return AccessToken.fromJson(response);
  }

  private string buildQueryString(string[string] params) {
    import std.array : appender;
    
    auto result = appender!string;
    bool first = true;
    
    foreach (key, value; params) {
      if (!first) result.put("&");
      result.put(encodeComponent(key));
      result.put("=");
      result.put(encodeComponent(value));
      first = false;
    }
    
    return result.data;
  }
}