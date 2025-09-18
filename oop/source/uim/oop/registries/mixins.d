module uim.oop.registries.mixins;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:
mixin(Version!("test_uim_oop"));

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
    string fullName = name ~ "Registry";
    return objCalls(fullName);
}

template RegistryCalls(string name) {
    const char[] RegistryCalls = registryCalls(name);
}


string registryCalls(string className, string instanceName, string typeName) {
  return "
auto "
    ~ instanceName ~ "Registry() { return " ~ className ~ "Registry.instance; }
auto "
    ~ instanceName ~ "Registry(string key, " ~ typeName ~ " registerObject) { 
  return "
    ~ instanceName ~ "Registry.register(key, registerObject); }
auto "
    ~ instanceName ~ "Registry(string[] path) { return " ~ instanceName ~ "Registry.get(path); }
auto "
    ~ instanceName ~ "Registry(string key) { return " ~ instanceName ~ "Registry.get(key); }
";
}

template RegistryCalls(string className, string instanceName, string typeName) {
  const char[] RegistryCalls = registryCalls(className, instanceName, typeName);
}
