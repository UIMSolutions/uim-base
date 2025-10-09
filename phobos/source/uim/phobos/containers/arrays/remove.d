module uim.phobos.containers.arrays.remove;

auto removeAt(T)(T[] arr, size_t index) {
  import std.algorithm : remove;
  import std.array : array;
  if (index >= arr.length) {
    throw new Exception("Index out of bounds");
  }
  return arr.remove(index).array;
}

auto removeValue(T)(T[] arr, T value) {
  import std.algorithm : remove;
  import std.array : array;
  return arr.remove(value).array;
}

auto removeValues(T)(T[] arr, T[] values) {
  import std.algorithm : remove;
  import std.array : array;
  return arr.remove(values).array;
}

auto removeif(T)(T[] arr, bool delegate(T) dg) {
  import std.algorithm : removeIf;
  import std.array : array;
  return arr.removeIf(dg).array;
}

unittest {
  auto arr = [1, 2, 3, 4, 5];
  auto result1 = removeAt(arr, 2);
  assert(result1 == [1, 2, 4, 5]);

  auto result2 = removeValue(arr, 3);
  assert(result2 == [1, 2, 4, 5]);

  auto result3 = removeValues(arr, [2, 4]);
  assert(result3 == [1, 3, 5]);
}