/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module examples.google_oauth_example;

import vibe.vibe;
import oauth;
import std.stdio;

void main() @trusted {
  // Configuration
  auto clientId = "YOUR_GOOGLE_CLIENT_ID";
  auto clientSecret = "YOUR_GOOGLE_CLIENT_SECRET";
  auto redirectUri = "http://localhost:8080/oauth/callback";
  auto scopes = [
    GoogleOAuthProvider.SCOPE_OPENID,
    GoogleOAuthProvider.SCOPE_EMAIL,
    GoogleOAuthProvider.SCOPE_PROFILE
  ];

  // Create OAuth client
  auto client = GoogleOAuthProvider.createClient(clientId, clientSecret, redirectUri, scopes);
  
  // Create flow handler
  auto storage = new InMemoryTokenStorage();
  auto flow = new AuthorizationCodeFlow(client, storage);

  // Setup HTTP server
  auto settings = new HTTPServerSettings;
  settings.port = 8080;
  settings.sessionStore = new MemorySessionStore;

  auto router = new URLRouter;

  // Login route
  router.get("/login", (req, res) {
    auto authUrl = flow.startFlow("user-session");
    res.redirect(authUrl);
  });

  // OAuth callback route
  flow.registerCallbackRoute(router, "/oauth/callback", 
    (req, res, token) {
      // Get user info
      auto userInfo = client.getUserInfo(token);
      
      res.writeBody(
        "Login successful!\n" ~
        "Access Token: " ~ token.accessToken ~ "\n" ~
        "User Info: " ~ userInfo.toPrettyString()
      );
    }
  );

  // Protected route
  router.get("/profile", (req, res) {
    auto token = flow.getToken("user-session");
    
    if (!token) {
      res.redirect("/login");
      return;
    }

    auto userInfo = client.getUserInfo(token);
    res.writeJsonBody(userInfo);
  });

  // Home page
  router.get("/", (req, res) {
    res.writeBody(`
      <html>
        <body>
          <h1>OAuth Example</h1>
          <a href="/login">Login with Google</a><br>
          <a href="/profile">View Profile</a>
        </body>
      </html>
    `, "text/html");
  });

  logInfo("Server running on http://localhost:8080");
  listenHTTP(settings, router);
  runApplication();
}