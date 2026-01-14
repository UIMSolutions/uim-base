/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module domain.repositories.user_repository;

import domain.entities.user;
import std.uuid;

@safe:

/**
 * Repository interface for user persistence
 */
interface IUserRepository {
  void save(User user);
  User findById(UUID id);
  User findByUsername(string username);
  User findByEmail(string email);
  User[] findAll();
  User[] findByRole(UserRole role);
  User[] findByStatus(UserStatus status);
  void remove(UUID id);
  bool exists(UUID id);
  bool existsByUsername(string username);
  bool existsByEmail(string email);
  size_t count();
}