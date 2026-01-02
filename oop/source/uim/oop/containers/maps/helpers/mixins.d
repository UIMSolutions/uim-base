/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.maps.helpers.mixins;

import uim.oop;

mixin(Version!("test_uim_oop"));

@safe:

string mapThis(string name = null, bool overrideMemberNames = true) {
  string fullName = name ~ "Map";
  return objThis(fullName, overrideMemberNames);
}

template MapThis(string name = null, bool overrideMemberNames = true) {
  const char[] MapThis = mapThis(name, overrideMemberNames);
}

string mapCalls(string name) {
  string fullName = name ~ "Map";
  return objCalls(fullName);
}

template MapCalls(string name) {
  const char[] MapCalls = mapCalls(name);
}
