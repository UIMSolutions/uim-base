/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module oauth.providers.google;

import oauth.core.config;
import oauth.client.oauth_client;

@safe:

/**
 * Google OAuth provider
 */
class GoogleOAuthProvider {
  static OAuthConfig createConfig(string clientId, string clientSecret, string redirectUri, string[] scopes = []) {
    auto config = OAuthConfig(clientId, clientSecret, redirectUri, scopes);
    config.authorizationEndpoint = "https://accounts.google.com/o/oauth2/v2/auth";
    config.tokenEndpoint = "https://oauth2.googleapis.com/token";
    config.userInfoEndpoint = "https://www.googleapis.com/oauth2/v2/userinfo";
    return config;
  }

  static OAuthClient createClient(string clientId, string clientSecret, string redirectUri, string[] scopes = []) {
    auto config = createConfig(clientId, clientSecret, redirectUri, scopes);
    return new OAuthClient(config);
  }

  // Common Google scopes
  static immutable string SCOPE_EMAIL = "https://www.googleapis.com/auth/userinfo.email";
  static immutable string SCOPE_PROFILE = "https://www.googleapis.com/auth/userinfo.profile";
  static immutable string SCOPE_OPENID = "openid";
  static immutable string SCOPE_DRIVE = "https://www.googleapis.com/auth/drive";
  static immutable string SCOPE_CALENDAR = "https://www.googleapis.com/auth/calendar";
}