/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.mixins.functions;

import uim.core;

mixin(Version!("test_uim_core"));
@safe:

template OFunction(string fName, string fParameters, string fBody) {
  const char[] TFunction = "
    void "~fName~"("~fParameters~") {"~fBody~" }";
}

template TFunction(string fName, string fParameters, string fBody) {
  const char[] TFunction = "
    O "~fName~"(this O)("~fParameters~") {"~fBody~" return cast(O)this; }";
}

auto tFunc(string fName, string[][] functions) {
  char[] x;
  if (functions.length == 1) return "O "~fName~"(this O)("~functions[0][0]~") {"~functions[0][1]~" return cast(O)this; }";
  if (functions.length > 1) return "O "~fName~"(this O)("~functions[0][0]~") {"~functions[0][1]~" return cast(O)this; }"~tFunc(fName, functions[1..$]);
  return null; 
}

template TFunction(string fName, string[][] functions) {
  const char[] TFunction = tFunc(fName, functions);
}
