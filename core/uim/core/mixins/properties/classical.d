/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.core.mixins.properties.classical;

import std.string;

/// mixin for boolean properties
deprecated
template TBool(string name, string defaultValue = null, bool get = true, bool set = true) {
    const char[] TBool = `
    protected bool _`
        ~ name ~ `; 
    @property bool `
        ~ name ~ `() { return _` ~ name ~ `; }; 
    @property void `
        ~ name ~ `(bool new` ~ name ~ `) { _` ~ name ~ ` = new` ~ name ~ `; };     
    `;
}

/// mixin for string properties
deprecated
template TString(string name, string defaultValue = null, bool get = true, bool set = true) {
    const char[] TString = `
    protected string _`
        ~ name ~ `; 
    @property string `
        ~ name ~ `() { return _` ~ name ~ `; }; 
    @property void `
        ~ name ~ `(string new` ~ name ~ `) { _` ~ name ~ ` = new` ~ name ~ `; };     
    `;
}
