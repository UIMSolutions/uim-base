module uim.phobos.containers.arrays.differences;

auto differences(T)(T[] arr1, T[] arr2) {
  import std.algorithm : setDifference;
  import std.array : array;
  return arr1.setDifference(arr2).array;
}

