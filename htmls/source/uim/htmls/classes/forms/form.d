module uim.htmls.classes.forms.form;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML form element
class DForm : DHtmlElement {
    this() {
        super("form");
    }

    auto action(string url) {
        return attribute("action", url);
    }

    auto method(string methodValue) {
        return attribute("method", methodValue);
    }

    auto post() {
        return method("POST");
    }

    auto get() {
        return method("GET");
    }

    auto enctype(string value) {
        return attribute("enctype", value);
    }
}

auto Form() { return new DForm(); }

unittest {
    auto form = Form().action("/submit").post();
    assert(form.toString().indexOf("action=\"/submit\"") > 0);
}
