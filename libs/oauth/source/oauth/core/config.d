/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module oauth.core.config;

@safe:

/**
 * OAuth configuration
 */
struct OAuthConfig {
  string clientId;
  string clientSecret;
  string redirectUri;
  string[] scopes;
  string authorizationEndpoint;
  string tokenEndpoint;
  string userInfoEndpoint;
  string state; // CSRF protection

  this(string clientId, string clientSecret, string redirectUri, string[] scopes = []) {
    this.clientId = clientId;
    this.clientSecret = clientSecret;
    this.redirectUri = redirectUri;
    this.scopes = scopes;
  }
}

/**
 * OAuth 2.0 grant types
 */
enum GrantType {
  AuthorizationCode = "authorization_code",
  Implicit = "implicit",
  ClientCredentials = "client_credentials",
  Password = "password",
  RefreshToken = "refresh_token"
}

/**
 * OAuth response types
 */
enum ResponseType {
  Code = "code",
  Token = "token"
}