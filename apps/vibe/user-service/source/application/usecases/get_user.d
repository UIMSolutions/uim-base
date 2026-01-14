/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module application.usecases.get_user;

import domain.entities.user;
import domain.repositories.user_repository;
import std.uuid;
import std.conv;

@safe:

/**
 * Use case for getting user details
 */
class GetUserUseCase {
  private IUserRepository _repository;

  this(IUserRepository repository) {
    _repository = repository;
  }

  UserDTO execute(UUID userId) {
    auto user = _repository.findById(userId);
    if (user is null) {
      throw new Exception("User not found");
    }

    return UserDTO.fromUser(user);
  }
}

struct UserDTO {
  string id;
  string username;
  string email;
  string firstName;
  string lastName;
  string fullName;
  string role;
  string status;
  string createdAt;
  string updatedAt;
  string lastLoginAt;

  static UserDTO fromUser(User user) {
    UserDTO dto;
    dto.id = user.id.toString();
    dto.username = user.username;
    dto.email = user.email;
    dto.firstName = user.firstName;
    dto.lastName = user.lastName;
    dto.fullName = user.fullName();
    dto.role = user.role.to!string;
    dto.status = user.status.to!string;
    dto.createdAt = user.createdAt.toISOExtString();
    dto.updatedAt = user.updatedAt.toISOExtString();
    dto.lastLoginAt = user.lastLoginAt != SysTime.init ? user.lastLoginAt.toISOExtString() : "";
    return dto;
  }
}