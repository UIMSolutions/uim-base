/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module infrastructure.persistence.memory_user_repository;

import domain.entities.user;
import domain.repositories.user_repository;
import std.uuid;
import std.algorithm;
import std.array;

@safe:

/**
 * In-memory implementation of user repository
 */
class InMemoryUserRepository : IUserRepository {
  private User[UUID] _users;
  private User[string] _usersByUsername;
  private User[string] _usersByEmail;

  void save(User user) {
    _users[user.id] = user;
    _usersByUsername[user.username] = user;
    _usersByEmail[user.email] = user;
  }

  User findById(UUID id) {
    return _users.get(id, null);
  }

  User findByUsername(string username) {
    return _usersByUsername.get(username, null);
  }

  User findByEmail(string email) {
    return _usersByEmail.get(email, null);
  }

  User[] findAll() {
    return _users.values.array;
  }

  User[] findByRole(UserRole role) {
    return _users.values
      .filter!(u => u.role == role)
      .array;
  }

  User[] findByStatus(UserStatus status) {
    return _users.values
      .filter!(u => u.status == status)
      .array;
  }

  void remove(UUID id) {
    if (auto user = id in _users) {
      _usersByUsername.remove(user.username);
      _usersByEmail.remove(user.email);
      _users.remove(id);
    }
  }

  bool exists(UUID id) {
    return (id in _users) !is null;
  }

  bool existsByUsername(string username) {
    return (username in _usersByUsername) !is null;
  }

  bool existsByEmail(string email) {
    return (email in _usersByEmail) !is null;
  }

  size_t count() {
    return _users.length;
  }
}