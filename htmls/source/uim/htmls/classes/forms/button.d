module uim.htmls.classes.forms.button;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML button element
class DButton : DHtmlElement {
    this() {
        super("button");
    }

    auto type(string typeValue) {
        return attribute("type", typeValue);
    }

    auto submit() {
        return type("submit");
    }

    auto reset() {
        return type("reset");
    }

    auto disabled() {
        return attribute("disabled", "");
    }
}

auto Button() { return new DButton(); }
auto Button(string text) { auto btn = new DButton(); btn.text(text); return btn; }
auto ButtonSubmit(string text = "Submit") { auto btn = new DButton(); btn.text(text).submit(); return btn; }
auto ButtonReset(string text = "Reset") { auto btn = new DButton(); btn.text(text).reset(); return btn; }

unittest {
    auto btn = Button("Click me");
    assert(btn.toString() == "<button>Click me</button>");
}
