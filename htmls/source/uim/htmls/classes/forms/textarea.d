module uim.htmls.classes.forms.textarea;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML textarea element
class DTextarea : DHtmlElement {
    this() {
        super("textarea");
    }

    auto name(string nameValue) {
        return attribute("name", nameValue);
    }

    auto rows(string rowCount) {
        return attribute("rows", rowCount);
    }

    auto cols(string colCount) {
        return attribute("cols", colCount);
    }

    auto placeholder(string text) {
        return attribute("placeholder", text);
    }

    auto required() {
        return attribute("required", "");
    }

    auto disabled() {
        return attribute("disabled", "");
    }

    auto readonly() {
        return attribute("readonly", "");
    }
}

auto Textarea() { return new DTextarea(); }
auto Textarea(string name) { auto ta = new DTextarea(); ta.name(name); return ta; }

unittest {
    auto ta = Textarea("comment");
    assert(ta.toString().indexOf("textarea") > 0);
}
