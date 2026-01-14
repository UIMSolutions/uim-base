/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module infrastructure.web.controllers.user_controller;

import vibe.vibe;
import application.usecases;
import domain.entities.user;
import std.uuid;
import std.conv;

@safe:

/**
 * REST API controller for user operations
 */
class UserController {
  private RegisterUserUseCase _registerUseCase;
  private AuthenticateUserUseCase _authenticateUseCase;
  private GetUserUseCase _getUserUseCase;
  private UpdateUserUseCase _updateUseCase;
  private ListUsersUseCase _listUseCase;

  this(
    RegisterUserUseCase registerUseCase,
    AuthenticateUserUseCase authenticateUseCase,
    GetUserUseCase getUserUseCase,
    UpdateUserUseCase updateUseCase,
    ListUsersUseCase listUseCase
  ) {
    _registerUseCase = registerUseCase;
    _authenticateUseCase = authenticateUseCase;
    _getUserUseCase = getUserUseCase;
    _updateUseCase = updateUseCase;
    _listUseCase = listUseCase;
  }

  void registerRoutes(URLRouter router) @trusted {
    router.post("/api/users/register", &register);
    router.post("/api/users/login", &login);
    router.get("/api/users", &listUsers);
    router.get("/api/users/:id", &getUser);
    router.put("/api/users/:id", &updateUser);
    router.delete("/api/users/:id", &deleteUser);
  }

  void register(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    try {
      auto json = req.json;
      
      auto request = RegisterUserRequest(
        json["username"].get!string,
        json["email"].get!string,
        json["password"].get!string,
        json["firstName"].get!string,
        json["lastName"].get!string
      );

      auto response = _registerUseCase.execute(request);
      
      res.statusCode = HTTPStatus.created;
      res.writeJsonBody([
        "success": true,
        "userId": response.userId.toString(),
        "message": response.message
      ]);
    } catch (Exception e) {
      res.statusCode = HTTPStatus.badRequest;
      res.writeJsonBody([
        "success": false,
        "error": e.msg
      ]);
    }
  }

  void login(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    try {
      auto json = req.json;
      
      auto request = AuthenticateUserRequest(
        json["username"].get!string,
        json["password"].get!string
      );

      auto response = _authenticateUseCase.execute(request);
      
      res.writeJsonBody([
        "success": true,
        "userId": response.userId.toString(),
        "username": response.username,
        "fullName": response.fullName,
        "email": response.email,
        "role": response.role.to!string,
        "token": response.token,
        "message": response.message
      ]);
    } catch (Exception e) {
      res.statusCode = HTTPStatus.unauthorized;
      res.writeJsonBody([
        "success": false,
        "error": e.msg
      ]);
    }
  }

  void listUsers(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    try {
      auto request = ListUsersRequest();
      
      if (auto role = "role" in req.query) {
        request.role = (*role).to!UserRole;
      }
      if (auto status = "status" in req.query) {
        request.status = (*status).to!UserStatus;
      }

      auto response = _listUseCase.execute(request);
      
      res.writeJsonBody([
        "success": true,
        "users": response.users.serializeToJson(),
        "totalCount": response.totalCount
      ]);
    } catch (Exception e) {
      res.statusCode = HTTPStatus.badRequest;
      res.writeJsonBody([
        "success": false,
        "error": e.msg
      ]);
    }
  }

  void getUser(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    try {
      auto userId = UUID(req.params["id"]);
      auto user = _getUserUseCase.execute(userId);
      
      res.writeJsonBody([
        "success": true,
        "user": user.serializeToJson()
      ]);
    } catch (Exception e) {
      res.statusCode = HTTPStatus.notFound;
      res.writeJsonBody([
        "success": false,
        "error": e.msg
      ]);
    }
  }

  void updateUser(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    try {
      auto json = req.json;
      auto userId = UUID(req.params["id"]);
      
      auto request = UpdateUserRequest(
        userId,
        json["firstName"].get!string,
        json["lastName"].get!string,
        json["email"].get!string
      );

      auto response = _updateUseCase.execute(request);
      
      res.writeJsonBody([
        "success": response.success,
        "message": response.message
      ]);
    } catch (Exception e) {
      res.statusCode = HTTPStatus.badRequest;
      res.writeJsonBody([
        "success": false,
        "error": e.msg
      ]);
    }
  }

  void deleteUser(HTTPServerRequest req, HTTPServerResponse res) @trusted {
    res.writeJsonBody(["message": "Delete user - Not implemented yet"]);
  }
}