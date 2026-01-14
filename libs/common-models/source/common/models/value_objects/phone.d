/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.value_objects.phone;

import std.string;
import std.algorithm;
import std.array;

@safe:

/**
 * Phone number value object
 */
struct PhoneNumber {
  private string _value;
  private string _countryCode;

  this(string phone, string countryCode = "+1") {
    auto cleaned = cleanPhoneNumber(phone);
    if (!isValid(cleaned)) {
      throw new Exception("Invalid phone number: " ~ phone);
    }
    _value = cleaned;
    _countryCode = countryCode;
  }

  string value() const { return _value; }
  string countryCode() const { return _countryCode; }
  
  string formatted() const {
    return _countryCode ~ " " ~ _value;
  }

  private static string cleanPhoneNumber(string phone) {
    return phone.filter!(c => c >= '0' && c <= '9').array.idup;
  }

  private static bool isValid(string phone) {
    return phone.length >= 10 && phone.length <= 15;
  }

  string toString() const {
    return formatted();
  }
}