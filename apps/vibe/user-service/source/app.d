/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module app;

import vibe.vibe;
import infrastructure.persistence.memory_user_repository;
import application.usecases;
import infrastructure.web.controllers.user_controller;

@safe:

/**
 * User Management Microservice - Entry Point
 */
void main() @trusted {
  // Setup repository
  auto userRepo = new InMemoryUserRepository();

  // Setup use cases
  auto registerUseCase = new RegisterUserUseCase(userRepo);
  auto authenticateUseCase = new AuthenticateUserUseCase(userRepo);
  auto getUserUseCase = new GetUserUseCase(userRepo);
  auto updateUseCase = new UpdateUserUseCase(userRepo);
  auto listUseCase = new ListUsersUseCase(userRepo);

  // Setup controller
  auto userController = new UserController(
    registerUseCase,
    authenticateUseCase,
    getUserUseCase,
    updateUseCase,
    listUseCase
  );

  // Configure HTTP server
  auto settings = new HTTPServerSettings;
  settings.port = 8081;
  settings.bindAddresses = ["0.0.0.0"];
  settings.errorPageHandler = toDelegate(&errorPage);
  
  auto router = new URLRouter;
  
  // Register API routes
  userController.registerRoutes(router);
  
  // Health check endpoint
  router.get("/health", (req, res) {
    res.writeJsonBody([
      "status": "healthy",
      "service": "user-service",
      "version": "1.0.0"
    ]);
  });

  // API documentation endpoint
  router.get("/", (req, res) {
    res.writeBody(`
      <html>
        <head><title>User Management Microservice</title></head>
        <body>
          <h1>User Management Microservice API</h1>
          <h2>Endpoints:</h2>
          <ul>
            <li>POST /api/users/register - Register new user</li>
            <li>POST /api/users/login - Authenticate user</li>
            <li>GET /api/users - List all users</li>
            <li>GET /api/users/:id - Get user by ID</li>
            <li>PUT /api/users/:id - Update user</li>
            <li>DELETE /api/users/:id - Delete user</li>
            <li>GET /health - Health check</li>
          </ul>
        </body>
      </html>
    `, "text/html");
  });

  logInfo("Starting User Management Microservice on http://0.0.0.0:8081");
  listenHTTP(settings, router);
  
  runApplication();
}

void errorPage(HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error) @trusted {
  res.writeJsonBody([
    "error": error.message,
    "code": error.code
  ]);
}