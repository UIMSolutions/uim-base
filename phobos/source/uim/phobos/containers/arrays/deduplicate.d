module uim.phobos.containers.arrays.deduplicate;

auto deduplicate(T)(T[] arr) {
  import std.algorithm : unique;
  import std.array : array;
  return arr.dup.unique.array;
}