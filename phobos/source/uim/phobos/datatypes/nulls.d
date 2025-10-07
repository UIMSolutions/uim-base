/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.datatypes.nulls;

import uim.phobos;

@safe:

auto Null(T)() {
  return T.init;
}

auto Null(T:Object)() {
  return null;
}

auto Null(T : bool)() {
  return false;
}

unittest {
  assert(Null!bool == false);
  assert(Null!bool != true);
}
// #endregion bool

// #region int
T Null(T : int)() {
  return 0;
}

T Null(T : int[])() {
  return 0;
}

unittest {
  assert(Null!int == 0);
  assert(Null!int != 1);
}
// #endregion int

// #region long
T Null(T : long)() {
  return 0;
}

T Null(T : long[])() {
  return 0;
}
// #endregion long

// #region float
T Null(T : float)() {
  return 0.0;
}

T Null(T : float[])() {
  return 0.0;
}
// #endregion float

// #region double
T Null(T : double)() {
  return 0.0;
}

T Null(T : double[])() {
  return 0.0;
}
// #endregion double

// #region string
T Null(T : string)() {
  return null;
}

T Null(T : string[])() {
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
