module uim.phobos.containers.arrays.shuffle;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

/** 
    * Shuffles the elements of an array in place.
    *
    * Params:
    *   values - The array to shuffle.
    *
    * Returns:
    *   The shuffled array.
    */
auto shuffle(T)(T[] values) {
  if (values.length <= 1)
    return values;

  auto rng = std.random.defaultRng;
  for (size_t i = values.length - 1; i > 0; --i) {
    size_t j = uniform(0, i + 1, rng);
    swap(values[i], values[j]);
  }
  return values;
}
