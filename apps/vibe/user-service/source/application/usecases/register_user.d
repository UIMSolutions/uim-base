/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module application.usecases.register_user;

import domain.entities.user;
import domain.repositories.user_repository;
import std.uuid;
import std.digest.sha;
import std.string;

@safe:

/**
 * Use case for registering a new user
 */
class RegisterUserUseCase {
  private IUserRepository _repository;

  this(IUserRepository repository) {
    _repository = repository;
  }

  RegisterUserResponse execute(RegisterUserRequest request) {
    // Validate input
    validateRequest(request);

    // Check if username already exists
    if (_repository.existsByUsername(request.username)) {
      throw new Exception("Username already exists");
    }

    // Check if email already exists
    if (_repository.existsByEmail(request.email)) {
      throw new Exception("Email already exists");
    }

    // Hash password
    auto passwordHash = hashPassword(request.password);

    // Create user
    auto user = new User(
      request.username,
      request.email,
      passwordHash,
      request.firstName,
      request.lastName
    );

    // Save to repository
    _repository.save(user);

    return RegisterUserResponse(user.id, "User registered successfully");
  }

  private void validateRequest(RegisterUserRequest request) {
    if (request.username.length < 3) {
      throw new Exception("Username must be at least 3 characters");
    }
    if (request.email.length == 0 || request.email.indexOf("@") == -1) {
      throw new Exception("Invalid email address");
    }
    if (request.password.length < 8) {
      throw new Exception("Password must be at least 8 characters");
    }
    if (request.firstName.length == 0) {
      throw new Exception("First name is required");
    }
    if (request.lastName.length == 0) {
      throw new Exception("Last name is required");
    }
  }

  private string hashPassword(string password) @trusted {
    import std.digest : toHexString;
    auto hash = sha256Of(password);
    return toHexString(hash).idup;
  }
}

struct RegisterUserRequest {
  string username;
  string email;
  string password;
  string firstName;
  string lastName;
}

struct RegisterUserResponse {
  UUID userId;
  string message;
}