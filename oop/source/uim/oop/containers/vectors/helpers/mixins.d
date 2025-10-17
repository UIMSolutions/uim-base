/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.vectors.helpers.mixins;

import uim.oop;

mixin(Version!("test_uim_oop"));
@safe:

string vectorThis(string name = null) {
  string fullName = name ~ "Vector";
  return objThis(fullName);
}

template VectorThis(string name = null) {
  const char[] VectorThis = vectorThis(name);
}

string vectorCalls(string name) {
  string fullName = name ~ "Vector";
  return objCalls(fullName);
}

template VectorCalls(string name) {
  const char[] VectorCalls = vectorCalls(name);
}