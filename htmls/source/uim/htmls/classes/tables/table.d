module uim.htmls.classes.tables.table;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML table element
class DTable : DHtmlElement {
    this() {
        super("table");
    }

    IHtmlAttribute border(string borderValue) {
        return attribute("border", borderValue);
    }

    IHtmlAttribute cellspacing(string value) {
        return attribute("cellspacing", value);
    }

    IHtmlAttribute cellpadding(string value) {
        return attribute("cellpadding", value);
    }
}

auto Table() { return new DTable(); }

unittest {
    auto table = Table();
    assert(table.toString() == "<table></table>");
}
