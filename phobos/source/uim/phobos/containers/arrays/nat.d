module uim.phobos.containers.arrays.nat;

auto natArray(T)(T[] arr) if (is(T == ubyte) || is(T == ushort) || is(T == uint) || is(T == ulong) || is(T == byte) || is(T == short) || is(T == int) || is(T == long)) {
  import std.array : array;
  import std.algorithm : map;
  return arr.map!(x => cast(nat)x).array;
}