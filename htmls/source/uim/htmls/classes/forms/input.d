module uim.htmls.classes.forms.input;

/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/

import uim.htmls;

@safe:

/// HTML input element
class DInput : DHtmlElement {
    this() {
        super("input");
        this.selfClosing(true);
    }

    auto type(string typeValue) {
        return attribute("type", typeValue);
    }

    override string name() {
        auto attr = attribute("name");
        return attr ? attr.value : null;
    }

    override auto name(string nameValue) {
        return attribute("name", nameValue);
    }

    auto value(string valueValue) {
        return attribute("value", valueValue);
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

    auto checked() {
        return attribute("checked", "");
    }
}

auto Input() { return new DInput(); }
auto InputText(string name = null) { auto input = new DInput(); input.type("text"); if (name) input.name(name); return input; }
auto InputPassword(string name = null) { auto input = new DInput(); input.type("password"); if (name) input.name(name); return input; }
auto InputEmail(string name = null) { auto input = new DInput(); input.type("email"); if (name) input.name(name); return input; }
auto InputNumber(string name = null) { auto input = new DInput(); input.type("number"); if (name) input.name(name); return input; }
auto InputCheckbox(string name = null) { auto input = new DInput(); input.type("checkbox"); if (name) input.name(name); return input; }
auto InputRadio(string name = null) { auto input = new DInput(); input.type("radio"); if (name) input.name(name); return input; }
auto InputFile(string name = null) { auto input = new DInput(); input.type("file"); if (name) input.name(name); return input; }
auto InputHidden(string name = null) { auto input = new DInput(); input.type("hidden"); if (name) input.name(name); return input; }
auto InputSubmit(string value = "Submit") { auto input = new DInput(); input.type("submit"); input.value(value); return input; }

unittest {
    auto input = InputText("username");
    assert(input.toString().indexOf("type=\"text\"") > 0);
}
