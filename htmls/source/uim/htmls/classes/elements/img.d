module uim.htmls.classes.elements.img;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML image element
class DImg : DHtmlElement {
    this() {
        super("img");
        this.selfClosing(true);
    }

    auto src(string source) {
        return attribute("src", source);
    }

    auto alt(string altText) {
        return attribute("alt", altText);
    }

    auto width(string w) {
        return attribute("width", w);
    }

    auto height(string h) {
        return attribute("height", h);
    }
}

auto Img() { return new DImg(); }
auto Img(string src, string alt = null) { 
    auto element = new DImg(); 
    element.src(src);
    if (alt) element.alt(alt);
    return element; 
}

unittest {
    auto img = Img("image.jpg", "Description");
    assert(img.toString() == `<img src="image.jpg" alt="Description" />`);
}
