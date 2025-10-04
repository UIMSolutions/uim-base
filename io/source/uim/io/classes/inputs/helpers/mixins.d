module uim.io.classes.inputs.helpers.mixins;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

string inputThis(string name = null) {
    string fullName = name ~ "Input";
    return objThis(fullName);
}

template InputThis(string name = null) {
    const char[] InputThis = inputThis(name);
}

string inputCalls(string name) {
    string fullName = name ~ "Input";
    return objCalls(fullName);
}

template InputCalls(string name) {
    const char[] InputCalls = inputCalls(name);
}
