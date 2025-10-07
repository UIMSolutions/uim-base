module uim.phobos.containers.arrays.without;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

auto without(T)(T[] values, T value) {
  return values.filter!(v => v != value).array;
}

auto withoutMany(T)(T[] values, T[] toRemove) {
  return values.filter!(v => !(toRemove.has(v))).array;
}

unittest {
  // Test without with int
  int[] arr = [1, 2, 3, 2, 4];
  auto result = without(arr, 2);
  assert(result.equal([1, 3, 4]));

  // Test without with string
  string[] arrStr = ["a", "b", "c", "b"];
  auto resultStr = without(arrStr, "b");
  assert(resultStr.equal(["a", "c"]));

  // Test withoutMany with int
  int[] arr2 = [1, 2, 3, 4, 5, 6];
  int[] toRemove = [2, 4, 6];
  auto result2 = withoutMany(arr2, toRemove);
  assert(result2.equal([1, 3, 5]));

  // Test withoutMany with string
  string[] arrStr2 = ["apple", "banana", "cherry", "banana", "date"];
  string[] toRemoveStr = ["banana", "date"];
  auto resultStr2 = withoutMany(arrStr2, toRemoveStr);
  assert(resultStr2.equal(["apple", "cherry"]));

  // Test empty input
  int[] emptyArr;
  auto resultEmpty = without(emptyArr, 1);
  assert(resultEmpty.length == 0);

  auto resultEmptyMany = withoutMany(emptyArr, [1, 2]);
  assert(resultEmptyMany.length == 0);

  // Test removing value not present
  int[] arr3 = [1, 2, 3];
  auto result3 = without(arr3, 4);
  assert(result3.equal([1, 2, 3]));

  auto result3Many = withoutMany(arr3, [4, 5]);
  assert(result3Many.equal([1, 2, 3]));
}
