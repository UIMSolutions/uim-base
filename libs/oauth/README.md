# OAuth Library for D and vibe.d

A comprehensive OAuth 2.0 library for D language and vibe.d framework.

## Features

- **OAuth 2.0 Flows**: Authorization Code, Client Credentials, Password, Refresh Token
- **Popular Providers**: Google, GitHub, Facebook (easily extensible)
- **Token Management**: Automatic refresh, storage (in-memory and file-based)
- **CSRF Protection**: Built-in state parameter validation
- **Resource Server**: Middleware for protecting API routes
- **Type-Safe**: Fully type-safe implementation
- **Easy Integration**: Simple API with vibe.d applications

## Installation

Add to your `dub.json`:

```json
{
  "dependencies": {
    "oauth": "*"
  }
}
```

## Quick Start

### Google OAuth Example

```d
import vibe.vibe;
import oauth;

void main() {
  // Setup OAuth client
  auto client = GoogleOAuthProvider.createClient(
    "YOUR_CLIENT_ID",
    "YOUR_CLIENT_SECRET",
    "http://localhost:8080/callback",
    [GoogleOAuthProvider.SCOPE_EMAIL, GoogleOAuthProvider.SCOPE_PROFILE]
  );

  // Create authorization flow
  auto flow = new AuthorizationCodeFlow(client);

  auto router = new URLRouter;

  // Login endpoint
  router.get("/login", (req, res) {
    auto authUrl = flow.startFlow("user");
    res.redirect(authUrl);
  });

  // OAuth callback
  flow.registerCallbackRoute(router, "/callback",
    (req, res, token) {
      auto userInfo = client.getUserInfo(token);
      res.writeJsonBody(userInfo);
    }
  );

  auto settings = new HTTPServerSettings;
  settings.port = 8080;
  listenHTTP(settings, router);
  runApplication();
}
```

### GitHub OAuth Example

```d
auto client = GitHubOAuthProvider.createClient(
  clientId, 
  clientSecret, 
  redirectUri,
  [GitHubOAuthProvider.SCOPE_USER]
);
```

### Facebook OAuth Example

```d
auto client = FacebookOAuthProvider.createClient(
  clientId,
  clientSecret,
  redirectUri,
  [FacebookOAuthProvider.SCOPE_EMAIL]
);
```

## Manual Flow Control

```d
auto client = new OAuthClient(config);

// Get authorization URL
auto authUrl = client.getAuthorizationUrl(state);

// Exchange code for token
auto token = client.exchangeCode(code, state);

// Refresh token
auto newToken = client.refreshToken(token.refreshToken);

// Make authenticated request
auto data = client.makeRequest("https://api.example.com/user", token);
```

## Token Storage

### In-Memory Storage

```d
auto storage = new InMemoryTokenStorage();
storage.store("user-id", token);
auto token = storage.retrieve("user-id");
```

### File-Based Storage

```d
auto storage = new FileTokenStorage("./tokens");
storage.store("user-id", token);
auto token = storage.retrieve("user-id");
```

## Protecting Routes

```d
auto validateToken = (string token) {
  // Validate token logic
  return true;
};

auto resourceServer = new ResourceServer(validateToken);

router.any("*", &resourceServer.protectRoute);
router.get("/api/protected", (req, res) {
  res.writeBody("Protected resource");
});
```

## Token Management

```d
// Check if token is expired
if (token.isExpired()) {
  token = client.refreshToken(token.refreshToken);
}

// Get authorization header
auto header = token.getAuthorizationHeader(); // "Bearer <token>"

// Check scopes
if (token.hasScope("email")) {
  // Access email
}
```

## Custom OAuth Provider

```d
auto config = OAuthConfig(clientId, clientSecret, redirectUri, scopes);
config.authorizationEndpoint = "https://provider.com/oauth/authorize";
config.tokenEndpoint = "https://provider.com/oauth/token";
config.userInfoEndpoint = "https://provider.com/api/user";

auto client = new OAuthClient(config);
```

## Grant Types

### Authorization Code

```d
auto token = client.exchangeCode(code, state);
```

### Client Credentials

```d
auto token = client.getClientCredentialsToken();
```

### Password

```d
auto token = client.getPasswordToken(username, password);
```

### Refresh Token

```d
auto newToken = client.refreshToken(refreshToken);
```

## Error Handling

```d
try {
  auto token = client.exchangeCode(code, state);
} catch (AuthorizationException e) {
  writeln("Error: ", e.errorCode, " - ", e.errorDescription);
} catch (TokenException e) {
  writeln("Token error: ", e.msg);
} catch (InvalidStateException e) {
  writeln("CSRF protection: ", e.msg);
}
```

## Running Examples

```bash
# Google OAuth example
dub run oauth:google-example

# GitHub OAuth example
dub run oauth:github-example
```

## Configuration

Set up OAuth credentials:

1. **Google**: https://console.cloud.google.com/
2. **GitHub**: https://github.com/settings/developers
3. **Facebook**: https://developers.facebook.com/

## API Reference

### OAuthClient

- `getAuthorizationUrl(state)` - Generate authorization URL
- `exchangeCode(code, state)` - Exchange code for token
- `refreshToken(refreshToken)` - Refresh access token
- `getClientCredentialsToken()` - Get token via client credentials
- `getPasswordToken(username, password)` - Get token via password
- `makeRequest(url, token, method)` - Make authenticated request
- `getUserInfo(token)` - Get user information

### AccessToken

- `accessToken()` - Get access token string
- `refreshToken()` - Get refresh token string
- `isExpired()` - Check if token is expired
- `hasScope(scope)` - Check if token has scope
- `getAuthorizationHeader()` - Get Bearer authorization header

## License

Apache 2.0
