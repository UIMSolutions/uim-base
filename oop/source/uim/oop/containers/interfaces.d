module uim.oop.containers.interfaces;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

interface IContainer {
  bool isEmpty();
  size_t length();

  bool clear();
}