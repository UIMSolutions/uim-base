/****************************************************************************************************************
* Copyright: © 2018-2026 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.htmls.classes.forms.interfaces;

import uim.htmls;

@safe:

/// Interface for form elements with name attribute
interface IHtmlForm {
  /// Get or set the name attribute
  string name();
  IHtmlForm name(string nameValue);

  IHtmlAttribute action(string url);

  IHtmlAttribute method(string methodValue);

  IHtmlForm post();

  IHtmlForm get();

  IHtmlAttribute enctype(string value);
}

unittest {
  class TestFormElement : DHtmlElement, IHtmlForm {
    this() {
      super("input");
    }

    override string name() {
      auto attr = attribute("name");
      return attr ? attr.value : null;
    }

    override IForm name(string nameValue) {
      attribute("name", nameValue);
      return this;
    }
  }

  auto element = new TestFormElement();
  element.name("testName");
  assert(element.name() == "testName");
}

interface IInput {
    IHtmlAttribute type(string typeValue);
}