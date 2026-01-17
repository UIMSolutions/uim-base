module uim.htmls.classes.forms.textarea;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML textarea element
class DTextarea : DHtmlElement, IHtmlElement {
    this() {
        super("textarea");
    }

    override string name() {
        auto attr = attribute("name");
        return attr ? attr.value : null;
    }

    IHtmlElement name(string nameValue) {
        attribute("name", nameValue);
        return this;
    }

    IHtmlAttribute rows(string rowCount) {
        return attribute("rows", rowCount);
    }

    IHtmlAttribute cols(string colCount) {
        return attribute("cols", colCount);
    }

    IHtmlAttribute placeholder(string text) {
        return attribute("placeholder", text);
    }

    IHtmlAttribute required() {
        return attribute("required", "");
    }

    IHtmlAttribute disabled() {
        return attribute("disabled", "");
    }

    IHtmlAttribute readonly() {
        return attribute("readonly", "");
    }
}

auto Textarea() { return new DTextarea(); }
auto Textarea(string name) { auto ta = new DTextarea(); ta.name(name); return ta; }

unittest {
    auto ta = Textarea("comment");
    assert(ta.toString().indexOf("textarea") > 0);
}
