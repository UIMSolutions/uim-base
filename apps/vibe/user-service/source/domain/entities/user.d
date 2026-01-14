/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module domain.entities.user;

import std.datetime;
import std.uuid;

@safe:

/**
 * User entity - Core domain model
 */
class User {
  private UUID _id;
  private string _username;
  private string _email;
  private string _passwordHash;
  private string _firstName;
  private string _lastName;
  private UserRole _role;
  private UserStatus _status;
  private SysTime _createdAt;
  private SysTime _updatedAt;
  private SysTime _lastLoginAt;

  this(string username, string email, string passwordHash, string firstName, string lastName) {
    _id = randomUUID();
    _username = username;
    _email = email;
    _passwordHash = passwordHash;
    _firstName = firstName;
    _lastName = lastName;
    _role = UserRole.User;
    _status = UserStatus.Active;
    _createdAt = Clock.currTime();
    _updatedAt = Clock.currTime();
  }

  // Getters
  UUID id() const { return _id; }
  string username() const { return _username; }
  string email() const { return _email; }
  string passwordHash() const { return _passwordHash; }
  string firstName() const { return _firstName; }
  string lastName() const { return _lastName; }
  UserRole role() const { return _role; }
  UserStatus status() const { return _status; }
  SysTime createdAt() const { return _createdAt; }
  SysTime updatedAt() const { return _updatedAt; }
  SysTime lastLoginAt() const { return _lastLoginAt; }

  // Business logic methods
  void updateProfile(string firstName, string lastName, string email) {
    if (_status == UserStatus.Deleted) {
      throw new Exception("Cannot update deleted user");
    }
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _updatedAt = Clock.currTime();
  }

  void changePassword(string newPasswordHash) {
    _passwordHash = newPasswordHash;
    _updatedAt = Clock.currTime();
  }

  void updateRole(UserRole newRole) {
    _role = newRole;
    _updatedAt = Clock.currTime();
  }

  void activate() {
    if (_status == UserStatus.Inactive) {
      _status = UserStatus.Active;
      _updatedAt = Clock.currTime();
    }
  }

  void deactivate() {
    if (_status == UserStatus.Active) {
      _status = UserStatus.Inactive;
      _updatedAt = Clock.currTime();
    }
  }

  void markAsDeleted() {
    _status = UserStatus.Deleted;
    _updatedAt = Clock.currTime();
  }

  void recordLogin() {
    _lastLoginAt = Clock.currTime();
  }

  string fullName() const {
    return _firstName ~ " " ~ _lastName;
  }

  bool isActive() const {
    return _status == UserStatus.Active;
  }
}

enum UserRole {
  User,
  Admin,
  SuperAdmin
}

enum UserStatus {
  Active,
  Inactive,
  Deleted
}