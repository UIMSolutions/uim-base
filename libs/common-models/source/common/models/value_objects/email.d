/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.value_objects.email;

import std.string;
import std.algorithm;

@safe:

/**
 * Email value object with validation
 */
struct Email {
  private string _value;

  this(string email) {
    if (!isValid(email)) {
      throw new Exception("Invalid email address: " ~ email);
    }
    _value = email.toLower();
  }

  string value() const { return _value; }

  static bool isValid(string email) {
    if (email.length == 0) return false;
    auto atIndex = email.indexOf("@");
    if (atIndex <= 0) return false;
    auto dotIndex = email.lastIndexOf(".");
    if (dotIndex <= atIndex) return false;
    return dotIndex < email.length - 1;
  }

  string toString() const {
    return _value;
  }

  bool opEquals(const Email other) const {
    return _value == other._value;
  }
}