/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.oop.containers.registries.helpers.mixins;

import uim.oop;

mixin(Version!"test_uim_oop");

@safe:
string registryThis(string name = null, bool overrideMemberNames = true) {
    string fullName = name ~ "Registry";
    return objThis(fullName, overrideMemberNames);
}

template RegistryThis(string name = null, bool overrideMemberNames = true) {
    const char[] RegistryThis = registryThis(name, overrideMemberNames);
}

string registryCalls(string name) {
  return "
auto "
    ~ name ~ "Registry() { return D" ~ name ~ "Registry.instance; }
auto "
    ~ name ~ "Registry(string[] path) { return " ~ name ~ "Registry.value(path); }
auto "
    ~ name ~ "Registry(string key) { return " ~ name ~ "Registry.value(key); }
";
}

template RegistryCalls(string name) {
  const char[] RegistryCalls = registryCalls(name);
}
