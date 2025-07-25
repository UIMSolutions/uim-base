module uim.phobos.datatypes.null_;

import uim.phobos;
@safe:

/*
T Null(T)() {
    return T.init;
}*/ 

// #region bool
T Null(T : bool)() {
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

unittest {
  assert(Null!int == 0);
  assert(Null!int != 1);
}
// #endregion int

// #region long
T Null(T : long)() {
  return 0;
}
// #endregion long

// #region float
T Null(T : float)() {
  return 0.0;
}
// #endregion float

// #region double
T Null(T : double)() {
  return 0.0;
}
// #endregion double

// #region string
T Null(T : string)() {
  return null;
}

unittest {
  assert(Null!string == null);
  assert(Null!string != "xxx");
}
// #endregion string

T Null(T:UUID)() {
    return UUID();
}

// #region Object
T Null(T:Object)(){
  return null; 
}
// #endregion Object
