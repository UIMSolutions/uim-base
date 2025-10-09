module uim.phobos.containers.arrays.fold;

auto foldl(T, U)(T[] arr, U init, U delegate(U, T) dg) {
  foreach (elem; arr) {
    init = dg(init, elem);
  }
  return init;
}
/// 
unittest {
  import std.stdio : writeln;
  import std.algorithm : sum;
  import std.array : array;

  auto arr = [1, 2, 3, 4, 5];
  auto result = foldl(arr, 0, (a, b) => a + b);
  assert(result == arr.sum);
  writeln("Foldl result: ", result); // Should print: Foldl result: 15

  auto strArr = ["Hello", " ", "World", "!"];
  auto strResult = foldl(strArr, "", (a, b) => a ~ b);
  assert(strResult == "Hello World!");
  writeln("Foldl string result: ", strResult); // Should print: Foldl string result: Hello World!
}