module uim.phobos.containers.arrays.rest;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

auto rest(T)(T[] values) {
  return values.length > 1 
    ? values[1 .. $]
    : null;
}