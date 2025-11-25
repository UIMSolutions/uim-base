/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.configurations.engines.helpers.mixins;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:

string configEngineThis(string name = null, bool overrideMemberNames = true) {
  string fullName = name ~ "ConfigEngine";
  return objThis(fullName, overrideMemberNames);
}

template ConfigEngineThis(string name = null, bool overrideMemberNames = true) {
  const char[] ConfigEngineThis = configEngineThis(name, overrideMemberNames);
}

string configEngineCalls(string name) {
  string fullName = name ~ "ConfigEngine";
  return objCalls(fullName);
}

template ConfigEngineCalls(string name) {
  const char[] ConfigEngineCalls = configEngineCalls(name);
}

mixin template TConfigEngine() {

}
