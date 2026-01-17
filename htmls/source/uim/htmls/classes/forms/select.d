module uim.htmls.classes.forms.select;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML option element
class DOption : DHtmlElement {
    this() {
        super("option");
    }

    auto value(string valueValue) {
        return attribute("value", valueValue);
    }

    auto selected() {
        return attribute("selected", "");
    }

    auto disabled() {
        return attribute("disabled", "");
    }
}

auto Option() { return new DOption(); }
auto Option(string value, string text) { auto opt = new DOption(); opt.value(value).text(text); return opt; }

/// HTML select element
class DSelect : DHtmlElement {
    this() {
        super("select");
    }

    IHtmlAttribute name() {
        return attribute("name");
    }

    DSelect name(string nameValue) {
        attribute("name", nameValue);
        return this;
    }

    IHtmlAttribute multiple() {
        return attribute("multiple", "");
    }

    IHtmlAttribute required() {
        return attribute("required", "");
    }

    IHtmlAttribute disabled() {
        return attribute("disabled", "");
    }

    auto addOption(string value, string text) {
        addChild(Option(value, text));
        return this;
    }
}

auto Select() { return new DSelect(); }
auto Select(string name) { auto sel = new DSelect(); sel.name(name); return sel; }

unittest {
    auto select = Select("country");
    select.addOption("us", "USA").addOption("uk", "UK");
    assert(select.toString().indexOf("select") > 0);
}
