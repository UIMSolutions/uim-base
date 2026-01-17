module uim.htmls.classes.lists.ol;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML ordered list element
class DOl : DHtmlElement {
    this() {
        super("ol");
    }

    auto type(string listType) {
        return attribute("type", listType);
    }

    auto start(string startValue) {
        return attribute("start", startValue);
    }
}

auto Ol() { return new DOl(); }

unittest {
    auto ol = Ol();
    assert(ol.toString() == "<ol></ol>");
}
