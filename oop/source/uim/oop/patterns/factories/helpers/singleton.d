/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.patterns.factories.helpers.singleton;

import uim.oop;

mixin(ShowModule!());

@safe:
/**
 * Singleton factory - ensures only one instance exists.
 */
class SingletonFactory(T) {
  private static T _instance;
  private T delegate() @safe _creator;

  this(T delegate() @safe creator) {
    _creator = creator;
  }

  T getInstance() {
    if (_instance is null) {
      _instance = _creator();
    }
    return _instance;
  }

  void reset() {
    _instance = null;
  }
}
