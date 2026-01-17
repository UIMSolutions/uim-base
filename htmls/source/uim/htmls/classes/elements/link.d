module uim.htmls.classes.elements.link;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML link element (for stylesheets, etc.)
class DLink : DHtmlElement {
    this() {
        super("link");
        this.selfClosing(true);
    }

    IHtmlAttribute rel(string relValue) {
        return attribute("rel", relValue);
    }

    IHtmlAttribute href(string url) {
        return attribute("href", url);
    }

    IHtmlAttribute type(string typeValue) {
        return attribute("type", typeValue);
    }
}

auto Link() { return new DLink(); }
auto Link(string href, string rel = "stylesheet") { 
    auto element = new DLink(); 
    element.href(href);
    element.rel(rel);
    return element; 
}

unittest {
    auto link = Link("style.css");
    assert(link.toString() == `<link href="style.css" rel="stylesheet" />`);
}
