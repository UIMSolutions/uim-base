/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.registries.helpers.mixins;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

@safe:
string registryThis(string name = null) {
    string fullName = name ~ "Registry";
    return objThis(fullName);
}

template RegistryThis(string name = null) {
    const char[] RegistryThis = registryThis(name);
}

string registryCalls(string name) {
  return "
auto "
    ~ name ~ "Registry() { return D" ~ name ~ "Registry.instance; }
auto "
    ~ name ~ "Registry(string[] path) { return " ~ name ~ "Registry.getPath(path); }
auto "
    ~ name ~ "Registry(string key) { return " ~ name ~ "Registry.getKey(key); }
";
}

template RegistryCalls(string name) {
  const char[] RegistryCalls = registryCalls(name);
}
