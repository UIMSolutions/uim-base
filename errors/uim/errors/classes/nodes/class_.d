/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.errors.classes.nodes.class_;

mixin(Version!("test_uim_errors"));

import uim.errors;
@safe:

// Dump node for objects/class instances.
class DClassErrorNode : DErrorNode {
    mixin(ErrorNodeThis!("Class"));

    this(string classname, int anId) {
        super();
        _classname = classname;
        _id = anId;
    }

    // Add a property
    void addProperty(DPropertyErrorNode node) {
        // _properties ~= node;
    }

    private string _classname;
    // Get the class name
    string classname() {
        return _classname;
    }
    void classname(string name) {
        _classname = name;
    }

    private int _id;
    // Get the reference id
    int id() {
        return _id;
    }
}
