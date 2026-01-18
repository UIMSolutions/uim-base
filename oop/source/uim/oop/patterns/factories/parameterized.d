module uim.oop.patterns.factories.parameterized;

import uim.oop;

mixin(ShowModule!());

@safe:

/**
 * Factory with parameters support.
 */
class ParameterizedFactory(T, Args...) {
  private T delegate(Args) @safe _creator;

  this(T delegate(Args) @safe creator) {
    _creator = creator;
  }

  T create(Args args) {
    return _creator(args);
  }
}