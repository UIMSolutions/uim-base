/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.htmls.classes.forms.form;

import uim.htmls;

@safe:

/// HTML form element
class DForm : DHtmlElement, IHtmlForm {
    this() {
        super("form");
    }

    IHtmlAttribute name() {
        return attribute("name");
    }

    override IHtmlForm name(string nameValue) {
        attribute("name", nameValue);
        return this;
    }
    
    IHtmlAttribute action(string url) {
        return attribute("action", url);
    }

    IHtmlAttribute method(string methodValue) {
        return attribute("method", methodValue);
    }

    IHtmlForm post() {
        return method("POST");
    }

    IHtmlForm get() {
        return method("GET");
    }

    IHtmlAttribute enctype(string value) {
        return attribute("enctype", value).value;
    }
}

auto Form() { return new DForm(); }

unittest {
    auto form = Form().action("/submit").post();
    assert(form.toString().indexOf("action=\"/submit\"") > 0);
}
