/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module application.usecases.update_user;

import domain.entities.user;
import domain.repositories.user_repository;
import std.uuid;

@safe:

/**
 * Use case for updating user profile
 */
class UpdateUserUseCase {
  private IUserRepository _repository;

  this(IUserRepository repository) {
    _repository = repository;
  }

  UpdateUserResponse execute(UpdateUserRequest request) {
    auto user = _repository.findById(request.userId);
    if (user is null) {
      throw new Exception("User not found");
    }

    // Check if email is being changed and if it's already taken
    if (request.email != user.email && _repository.existsByEmail(request.email)) {
      throw new Exception("Email already exists");
    }

    user.updateProfile(request.firstName, request.lastName, request.email);
    _repository.save(user);

    return UpdateUserResponse(true, "User updated successfully");
  }
}

struct UpdateUserRequest {
  UUID userId;
  string firstName;
  string lastName;
  string email;
}

struct UpdateUserResponse {
  bool success;
  string message;
}