/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.root.datatypes.nulls;

import uim.root;

mixin(ShowModule!());

@safe:
/**
  * Returns the null value for the given type T.
  *
  * Params:
  *   T = The type to get the null value for.
  *
  * Returns:
  *   The null value for the given type T.
  */
auto Null(T)() {
  return T.init;
}

// #region bool
auto Null(T : bool)() {
  return false;
}
/// 
unittest {
  mixin(ShowTest!"Testing Null for bool");

  assert(Null!bool == false);
  assert(Null!bool != true);
}
// #endregion bool

// #region integers
auto Null(T : ubyte)() {
  return 0;
}

auto Null(T : ushort)() {
  return 0;
}

auto Null(T : uint)() {
  return 0;
}

auto Null(T : ulong)() {
  return 0;
}

auto Null(T : byte)() {
  return 0;
}

auto Null(T : short)() {
  return 0;
}

auto Null(T : int)() {
  return 0;
}

auto Null(T : long)() {
  return 0;
}

unittest {
  assert(Null!int == 0);
  assert(Null!int != 1);

  assert(Null!long == 0);
  assert(Null!long != 1);
}
// #region integers

auto Null(T : Object)() {
  return null;
}

// #region floating
T Null(T : float)() {
  return 0.0;
}

T Null(T : double)() {
  return 0.0;
}

T Null(T : real)() {
  return 0.0;
}
// #endregion floating

// #region string
T Null(T : string)() {
  return null;
}
// #endregion string

T Null(T : UUID)() {
  return UUID();
}

T Null(T : Json)() if (is(T == Json)) {
  return Json(null);
}

// #region Object
/**
  * Returns null for Object types.
  *
  * Params:
  *   T = The Object type to get null for.
  *
  * Returns:
  *   null
  */
T Null(T : Object)() {
  return null;
}

// #endregion Object

T Null(T)() if (isArray!T) {
  return null;
}
