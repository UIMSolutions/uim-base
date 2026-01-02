/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.containers.sequential.arrays.chunks;

import uim.root;

mixin(Version!"test_uim_phobos");

@safe:
/** 
  * Splits an array into chunks of a specified size.
  *
  * Params:
  *   arr = The input array to be chunked.
  *   chunkSize = The size of each chunk.
  *
  * Returns:
  *   An array of arrays, where each inner array is a chunk of the specified size.
  *   The last chunk may be smaller if the total number of elements is not divisible by `chunkSize`.
  * ```
  */
auto chunks(T)(T[] arr, size_t chunkSize) {
  T[][] results;
  if (chunkSize == 0) {
    return results; // Return empty array if chunkSize is 0
  }
  for (size_t i = 0; i < arr.length; i += chunkSize) {
    results ~= arr[i .. (i + chunkSize > arr.length ? arr.length : i + chunkSize)];
  }
  return results;
}
///
unittest {
  auto result = chunks([1, 2, 3, 4, 5], 2);
  assert(result.length == 3);
  assert(result[0] == [1, 2]);
  assert(result[1] == [3, 4]);
  assert(result[2] == [5]);
}
