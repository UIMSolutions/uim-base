module uim.phobos.datatypes.values;

import uim.phobos;

@safe:


T[] removeValues(T)(T[] items, size_t[] indices) {
  return items.filter!((_, index) => !indices.contains(index));
}

T[] removeValues(T)(T[] items, bool delegate(T t) @safe removeFunc) {
  return items.removeValues(removeFunc);
}

T[] removeValue(T)(T[] items, size_t index) {
  if (index == 0) {
    return items.length > 1 ? items[1..$] : null; 
  }

  if (index+1 == items.length) {
    return items.length > 1 ? items[0..$-1] : null; 
  }

  return items.length > index ? items[0..index] ~ items[index+1..$] : items;
}