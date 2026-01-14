/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module application.usecases.authenticate_user;

import domain.entities.user;
import domain.repositories.user_repository;
import std.digest.sha;
import std.uuid;

@safe:

/**
 * Use case for user authentication
 */
class AuthenticateUserUseCase {
  private IUserRepository _repository;

  this(IUserRepository repository) {
    _repository = repository;
  }

  AuthenticateUserResponse execute(AuthenticateUserRequest request) {
    // Find user by username
    auto user = _repository.findByUsername(request.username);
    if (user is null) {
      throw new Exception("Invalid username or password");
    }

    // Check if user is active
    if (!user.isActive()) {
      throw new Exception("User account is not active");
    }

    // Verify password
    auto passwordHash = hashPassword(request.password);
    if (user.passwordHash != passwordHash) {
      throw new Exception("Invalid username or password");
    }

    // Record login
    user.recordLogin();
    _repository.save(user);

    // Generate token (simplified - in production use JWT)
    auto token = generateToken(user);

    return AuthenticateUserResponse(
      user.id,
      user.username,
      user.fullName(),
      user.email,
      user.role,
      token,
      "Authentication successful"
    );
  }

  private string hashPassword(string password) @trusted {
    import std.digest : toHexString;
    auto hash = sha256Of(password);
    return toHexString(hash).idup;
  }

  private string generateToken(User user) @trusted {
    import std.conv : to;
    import std.digest : toHexString;
    auto data = user.id.toString() ~ user.username ~ Clock.currTime().toISOExtString();
    auto hash = sha256Of(data);
    return toHexString(hash).idup;
  }
}

struct AuthenticateUserRequest {
  string username;
  string password;
}

struct AuthenticateUserResponse {
  UUID userId;
  string username;
  string fullName;
  string email;
  UserRole role;
  string token;
  string message;
}