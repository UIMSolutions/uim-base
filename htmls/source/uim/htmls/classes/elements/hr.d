module uim.htmls.classes.elements.hr;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML horizontal rule element
class DHr : DHtmlElement {
    this() {
        super("hr");
        this.selfClosing(true);
    }
}

auto Hr() { return new DHr(); }

unittest {
    auto hr = Hr();
    assert(hr.toString() == "<hr />");
}
