/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.htmls.classes.forms.option;

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
