module uim.oop.patterns.decorators.helpers.functional;

import uim.oop;

mixin(ShowModule!());

@safe:
/**
 * Helper function to create a functional decorator.
 */
FunctionalDecorator createFunctionalDecorator(
    IComponent component,
    string delegate() @safe beforeFunc = null,
    string delegate() @safe afterFunc = null) {
  return new FunctionalDecorator(component, beforeFunc, afterFunc);
}