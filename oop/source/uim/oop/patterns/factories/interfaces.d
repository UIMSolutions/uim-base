module uim.oop.patterns.factories.interfaces;

import uim.oop;

mixin(ShowModule!());

@safe:
/**
 * Factory interface for creating objects.
 */
interface IFactory(T) {
  T create();
}