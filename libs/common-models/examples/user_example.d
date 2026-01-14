/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module examples.user_example;

import common.models;
import std.uuid;
import std.stdio;

@safe:

/**
 * Example: User entity using common models
 */
class User : BaseEntity {
  private string _username;
  private Email _email;
  private string _firstName;
  private string _lastName;

  this(string username, string email, string firstName, string lastName, string createdBy) {
    super();
    _username = username;
    _email = Email(email);
    _firstName = firstName;
    _lastName = lastName;
    onCreate(createdBy);
  }

  string username() const { return _username; }
  Email email() const { return _email; }
  string firstName() const { return _firstName; }
  string lastName() const { return _lastName; }

  void updateProfile(string firstName, string lastName, string email, string userId) {
    if (isDeleted()) {
      throw new Exception("Cannot update deleted user");
    }
    _firstName = firstName;
    _lastName = lastName;
    _email = Email(email);
    onUpdate(userId);
  }
}

/**
 * Example: Product entity with money
 */
class Product : BaseEntity {
  private string _name;
  private string _description;
  private Money _price;
  private int _stock;

  this(string name, string description, Money price, int stock, string createdBy) {
    super();
    _name = name;
    _description = description;
    _price = price;
    _stock = stock;
    onCreate(createdBy);
  }

  string name() const { return _name; }
  Money price() const { return _price; }
  int stock() const { return _stock; }

  void updatePrice(Money newPrice, string userId) {
    _price = newPrice;
    onUpdate(userId);
  }

  void addStock(int quantity, string userId) {
    _stock += quantity;
    onUpdate(userId);
  }
}

/**
 * Example usage
 */
void main() @trusted {
  // Create user with email validation
  auto user = new User("johndoe", "john@example.com", "John", "Doe", "system");
  writeln("User created: ", user.username);
  writeln("Email: ", user.email.value);
  writeln("Version: ", user.version_);

  // Update profile
  user.updateProfile("John", "Smith", "john.smith@example.com", "admin");
  writeln("User updated. New version: ", user.version_);

  // Create product with money
  auto product = new Product(
    "Laptop",
    "High-performance laptop",
    Money(999.99, "USD"),
    10,
    "system"
  );
  writeln("Product: ", product.name, " - ", product.price);

  // Soft delete
  user.markAsDeleted("admin");
  writeln("User deleted: ", user.isDeleted);

  // Validation example
  auto validator = new ValidatorBuilder!User()
    .addRule(u => u.username.length >= 3, "Username must be at least 3 characters")
    .addRule(u => !u.isDeleted, "User is deleted");

  auto result = validator.validate(user);
  if (!result.isValid) {
    writeln("Validation errors:");
    foreach (error; result.errors) {
      writeln("  - ", error);
    }
  }
}