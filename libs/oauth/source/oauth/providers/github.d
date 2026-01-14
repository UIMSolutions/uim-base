/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module oauth.providers.github;

import oauth.core.config;
import oauth.client.oauth_client;

@safe:

/**
 * GitHub OAuth provider
 */
class GitHubOAuthProvider {
  static OAuthConfig createConfig(string clientId, string clientSecret, string redirectUri, string[] scopes = []) {
    auto config = OAuthConfig(clientId, clientSecret, redirectUri, scopes);
    config.authorizationEndpoint = "https://github.com/login/oauth/authorize";
    config.tokenEndpoint = "https://github.com/login/oauth/access_token";
    config.userInfoEndpoint = "https://api.github.com/user";
    return config;
  }

  static OAuthClient createClient(string clientId, string clientSecret, string redirectUri, string[] scopes = []) {
    auto config = createConfig(clientId, clientSecret, redirectUri, scopes);
    return new OAuthClient(config);
  }

  // Common GitHub scopes
  static immutable string SCOPE_USER = "user";
  static immutable string SCOPE_USER_EMAIL = "user:email";
  static immutable string SCOPE_REPO = "repo";
  static immutable string SCOPE_PUBLIC_REPO = "public_repo";
  static immutable string SCOPE_GIST = "gist";
}