module uim.root.containers.sequential.arrays.get;

import uim.root;

mixin(Version!("test_uim_phobos"));

@safe:

T[] getValues(T)(T[] values, bool delegate(T value) selectFunc) {
  T[] results;
  () @trusted { results = values.filter!(value => selectFunc(value)).array; }();
  return results;
}

T[] getValues(T)(T[] arrays, size_t[] indices) {
  return indices
    .filter!(index => index < arrays.length)
    .map!(index => arrays[index])
    .array;
}

T getValue(T)(T[] arrays, size_t index, T defaultValue = Null!T) {
  return arrays.length > index ? arrays[index] : defaultValue;
}