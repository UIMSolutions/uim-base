module uim.phobos.convert.null_;

import uim.phobos;
@safe:

// #region bool
V Null(V : bool)() {
  return false;
}

unittest {
  assert(Null!bool == false);
  assert(Null!bool != true);
}
// #endregion bool

// #region int
V Null(V : int)() {
  return 0;
}

unittest {
  assert(Null!int == 0);
  assert(Null!int != 1);
}
// #endregion int

// #region long
V Null(V : long)() {
  return 0;
}
// #endregion long

// #region float
V Null(V : float)() {
  return 0.0;
}
// #endregion float

// #region double
V Null(V : double)() {
  return 0.0;
}
// #endregion double

// #region string
V Null(V : string)() {
  return null;
}

unittest {
  assert(Null!string == null);
  assert(Null!string != "xxx");
}
// #endregion string

// #region Object
V Null(V:Object)(){
  return null; 
}
// #endregion Object
