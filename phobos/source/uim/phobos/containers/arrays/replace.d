module uim.phobos.containers.arrays.replace;

auto replace(T)(T[] arr, T oldValue, T newValue) {
  import std.algorithm : map;
  import std.array : array;
  return arr.map!(x => x == oldValue ? newValue : x).array;
}

auto replaceAll(T)(T[] arr, T[] oldValues, T newValue) {
  import std.algorithm : map;
  import std.array : array;
  return arr.map!(x => (x in oldValues) ? newValue : x).array;
}

auto replaceIf(T)(T[] arr, bool delegate(T) predicate, T newValue) {
  import std.algorithm : map;
  import std.array : array;
  return arr.map!(x => predicate(x) ? newValue : x).array;
}

unittest {
  auto arr = [1, 2, 3, 4, 5];
  auto result1 = replace(arr, 3, 99);
  assert(result1 == [1, 2, 99, 4, 5]);

  auto result2 = replaceAll(arr, [2, 4], 88);
  assert(result2 == [1, 88, 3, 88, 5]);

  auto result3 = replaceIf(arr, (x) => x % 2 == 0, 77);
  assert(result3 == [1, 77, 3, 77, 5]);
}