/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.factories.mixins;

mixin(Version!("test_uim_oop"));

import uim.oop;
@safe:

@safe:
string factoryThis(string name = null) {
    string fullName = name ~ "Factory";
    return objThis(fullName);
}

template FactoryThis(string name = null) {
    const char[] FactoryThis = factoryThis(name);
}

string factoryCalls(string name) {
    string fullName = name ~ "Factory";
    return objCalls(fullName);
}

template FactoryCalls(string name) {
    const char[] FactoryCalls = factoryCalls(name);
}

string factoryCalls(string className, string instanceName, string typeName) {
  return "
auto "
    ~ instanceName ~ "Factory() { return " ~ className ~ "Factory.instance; }
auto "
    ~ instanceName ~ "Factory(string key, " ~ typeName ~ " registerObject) { 
  return "
    ~ instanceName ~ "Factory.register(key, registerObject); }
auto "
    ~ instanceName ~ "Factory(string[] path) { return " ~ instanceName ~ "Factory.get(path); }
auto "
    ~ instanceName ~ "Factory(string key) { return " ~ instanceName ~ "Factory.get(key); }
";
}

template FactoryCalls(string className, string instanceName, string typeName) {
  const char[] FactoryCalls = factoryCalls(className, instanceName, typeName);
}
