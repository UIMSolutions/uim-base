/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module examples.github_oauth_example;

import vibe.vibe;
import oauth;

void main() @trusted {
  auto clientId = "YOUR_GITHUB_CLIENT_ID";
  auto clientSecret = "YOUR_GITHUB_CLIENT_SECRET";
  auto redirectUri = "http://localhost:8080/callback";
  auto scopes = [GitHubOAuthProvider.SCOPE_USER, GitHubOAuthProvider.SCOPE_USER_EMAIL];

  auto client = GitHubOAuthProvider.createClient(clientId, clientSecret, redirectUri, scopes);
  auto flow = new AuthorizationCodeFlow(client);

  auto settings = new HTTPServerSettings;
  settings.port = 8080;
  auto router = new URLRouter;

  router.get("/login", (req, res) {
    res.redirect(flow.startFlow("user"));
  });

  flow.registerCallbackRoute(router, "/callback",
    (req, res, token) {
      auto userInfo = client.getUserInfo(token);
      res.writeJsonBody([
        "message": "Login successful!",
        "user": userInfo
      ]);
    }
  );

  router.get("/", (req, res) {
    res.writeBody("<a href='/login'>Login with GitHub</a>", "text/html");
  });

  listenHTTP(settings, router);
  runApplication();
}