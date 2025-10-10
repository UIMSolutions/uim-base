/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.factories.mixins;

import uim.oop;

mixin(Version!("test_uim_oop"));
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
  return "
auto "
    ~ name ~ "Factory() { return D" ~ name ~ "Factory.instance; }
auto "
    ~ name ~ "Factory(string[] path) { return " ~ name ~ "Factory.create(path); }
auto "
    ~ name ~ "Factory(string key) { return " ~ name ~ "Factory.create(key); }
";
}

template FactoryCalls(string name) {
  const char[] FactoryCalls = factoryCalls(name);
}
