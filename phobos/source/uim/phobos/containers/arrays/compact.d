module uim.phobos.containers.arrays.compact;

auto compact(T)(T[] arr) {
  import std.algorithm : filter;
  import std.array : array;
  return arr.filter!(x => x !is null).array;
}