/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module common.models.value_objects.address;

@safe:

/**
 * Address value object
 */
struct Address {
  private string _street;
  private string _city;
  private string _state;
  private string _postalCode;
  private string _country;

  this(string street, string city, string state, string postalCode, string country) {
    if (street.length == 0) throw new Exception("Street is required");
    if (city.length == 0) throw new Exception("City is required");
    if (country.length == 0) throw new Exception("Country is required");

    _street = street;
    _city = city;
    _state = state;
    _postalCode = postalCode;
    _country = country;
  }

  string street() const { return _street; }
  string city() const { return _city; }
  string state() const { return _state; }
  string postalCode() const { return _postalCode; }
  string country() const { return _country; }

  string formatted() const {
    return _street ~ "\n" ~ _city ~ ", " ~ _state ~ " " ~ _postalCode ~ "\n" ~ _country;
  }

  string toString() const {
    return formatted();
  }
}