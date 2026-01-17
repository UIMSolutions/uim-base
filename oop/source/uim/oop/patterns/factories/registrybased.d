module uim.oop.patterns.factories.registrybased;

import uim.oop;

mixin(ShowModule!());

@safe:

/**
 * Registry-based factory for managing multiple product types.
 */ 
class RegisterBasedFactory(T) {
  private static Object delegate() @safe[string] _creators;

  /**
   * Register a creator function for a specific type.
   */ 
  static void register(string typeName, Object delegate() @safe creator) {
    _creators[typeName] = creator;
  }

  /**
   * Create an instance by type name.
   */ 
  static T create(string typeName) {
    if (auto creator = typeName in _creators) {
      return cast(T)(*creator)();
    }
    return null;
  }

  /**
   * Check if a type is registered.
   */ 
  static bool isRegistered(string typeName) {
    return (typeName in _creators) !is null;
  }

  /**
   * Unregister a type.
   */ 
  static void unregister(string typeName) {
    _creators.remove(typeName);
  }

  /**
   * Clear all registrations.
   */ 
  static void clear() {
    _creators.clear();
  }

  /**
   * Get all registered type names.
   */ 
  static string[] registeredTypes() {
    return _creators.keys;
  }
}