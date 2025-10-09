module uim.phobos.containers.arrays.intersect;

/** Returns the intersection of two arrays as a new array.
 * 
 * Params:
 *   arr1 = The first array.
 *   arr2 = The second array.
 * 
 * Returns:
 *   A new array containing the intersection of the two input arrays.
 * 
 * Example:
 * ```
 * import uim.phobos.containers.arrays.intersect : intersect;
 * 
 * auto arr1 = [1, 2, 3, 4, 5];
 * auto arr2 = [4, 5, 6, 7, 8];
 * auto result = intersect(arr1, arr2); // result is [4, 5]
 * ```
 */
auto intersect(T)(T[] values1, T[] values2) {
  import std.algorithm : filter, canFind;
  import std.array : array;

  return values1.filter!(item => values2.canFind(item)).array;
}
