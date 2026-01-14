/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module oauth.providers.facebook;

import oauth.core.config;
import oauth.client.oauth_client;

@safe:

/**
 * Facebook OAuth provider
 */
class FacebookOAuthProvider {
  static OAuthConfig createConfig(string clientId, string clientSecret, string redirectUri, string[] scopes = []) {
    auto config = OAuthConfig(clientId, clientSecret, redirectUri, scopes);
    config.authorizationEndpoint = "https://www.facebook.com/v12.0/dialog/oauth";
    config.tokenEndpoint = "https://graph.facebook.com/v12.0/oauth/access_token";
    config.userInfoEndpoint = "https://graph.facebook.com/me";
    return config;
  }

  static OAuthClient createClient(string clientId, string clientSecret, string redirectUri, string[] scopes = []) {
    auto config = createConfig(clientId, clientSecret, redirectUri, scopes);
    return new OAuthClient(config);
  }

  // Common Facebook scopes
  static immutable string SCOPE_PUBLIC_PROFILE = "public_profile";
  static immutable string SCOPE_EMAIL = "email";
  static immutable string SCOPE_USER_FRIENDS = "user_friends";
  static immutable string SCOPE_USER_POSTS = "user_posts";
}