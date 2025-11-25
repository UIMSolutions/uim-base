/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.parsers.helpers.functions;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

bool isParser(Object obj) {
  if (obj is null) {
    return false;
  }
  return cast(IParser)obj !is null;
}

bool isParser(IObject obj) {
  if (obj is null) {
    return false;
  }
  return cast(IParser)obj !is null;
}


auto Null(V : IParser)() {
  return null;
}

auto Null(V : DParser)() {
  return null;
}

unittest {
  auto parserNull = Null!IParser;
  assert(parserNull is null, "Test Null!IParser failed");

  auto dparserNull = Null!DParser;
  assert(dparserNull is null, "Test Null!DParser failed");
}