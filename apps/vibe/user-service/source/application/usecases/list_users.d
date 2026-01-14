/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module application.usecases.list_users;

import domain.entities.user;
import domain.repositories.user_repository;
import application.usecases.get_user;
import std.algorithm;
import std.array;

@safe:

/**
 * Use case for listing users
 */
class ListUsersUseCase {
  private IUserRepository _repository;

  this(IUserRepository repository) {
    _repository = repository;
  }

  ListUsersResponse execute(ListUsersRequest request) {
    User[] users;

    if (request.role != UserRole.init) {
      users = _repository.findByRole(request.role);
    } else if (request.status != UserStatus.init) {
      users = _repository.findByStatus(request.status);
    } else {
      users = _repository.findAll();
    }

    auto dtos = users.map!(u => UserDTO.fromUser(u)).array;
    return ListUsersResponse(dtos, users.length);
  }
}

struct ListUsersRequest {
  UserRole role;
  UserStatus status;
}

struct ListUsersResponse {
  UserDTO[] users;
  size_t totalCount;
}