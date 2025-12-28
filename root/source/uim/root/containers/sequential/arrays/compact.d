module uim.phobos.containers.arrays.compact;

import uim.phobos;

mixin(Version!("test_uim_phobos"));
@safe:

/** 
    Compacts an array by removing all `null` elements.

    Params:
        arr = The array to compact.

    Returns:
        A new array with all `null` elements removed.

    Example:
    ```d
    import uim.phobos.containers.arrays.compact : compact;

    auto arr = [1, null, 2, null, 3];
    auto compactedArr = compact(arr); // Result: [1, 2, 3]
    ```

    Note:
        This function works for arrays of reference types where `null` is a valid value.
*/
auto compact(T)(T[] arr) {
  return arr.filter!(x => x !is null).array;
}
///
unittest {
  auto strArr = ["hello", null, "world", null, "!"];

  auto compactedStrArr = compact(strArr);
  assert(compactedStrArr == ["hello", "world", "!"]);
  assert(compactedStrArr.length == 3);
}
