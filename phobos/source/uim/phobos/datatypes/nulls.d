/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.datatypes.nulls;

import uim.phobos;

@safe:

auto Null(T)() {
  return T.init;
}

// #region bool
auto Null(T : bool)() {
  return false;
}

unittest {
  assert(Null!bool == false);
  assert(Null!bool != true);
}
// #endregion bool

// #region integers
auto Null(T: ubyte)() {
  return 0;
}

auto Null(T: ushort)() {
  return 0;
}

auto Null(T: uint)() {
  return 0;
}

auto Null(T: ulong)() {
  return 0;
}

auto Null(T: byte)() {
  return 0;
}

auto Null(T: short)() {
  return 0;
}

auto Null(T: int)() {
  return 0;
}

auto Null(T: long)() {
  return 0;
}

unittest {
  assert(Null!int == 0);
  assert(Null!int != 1);

  assert(Null!long == 0);
  assert(Null!long != 1);
}
// #region integers

auto Null(T:Object)() {
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

unittest {
  assert(Null!string == null);
  assert(Null!string != "xxx");
}
// #endregion string

T Null(T : UUID)() {
  return UUID();
}

T Null(T : UUID[])() {
  return UUID();
}

// #region Object
T Null(T : Object)() {
  return null;
}

T Null(T : Object[])() {
  return null;
}
// #endregion Object
