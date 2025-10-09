module uim.phobos.containers.arrays.cross;

/** 
    * Generates the Cartesian product of two arrays.
    * Each element from the first array is paired with each element from the second array.
    *
    * Params:
    *   a = The first array.
    *   b = The second array.
    *
    * Returns:
    *   An array of tuples, where each tuple contains one element from `a` and one from `b`.
    * ```
    */
auto cross(T)(T[] a, T[] b) {
  import std.algorithm : map, joiner;
  import std.array : array;
  return a.map!(x => b.map!(y => tuple(x, y))).joiner.array;
}
///
unittest {
  auto result = cross([1, 2], ['a', 'b']);
  assert(result.length == 4);
  assert(result[0] == tuple(1, 'a'));
  assert(result[1] == tuple(1, 'b'));
  assert(result[2] == tuple(2, 'a'));
  assert(result[3] == tuple(2, 'b'));
}