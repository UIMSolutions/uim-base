module uim.htmls.classes.forms.checkbox;

import uim.htmls;

@safe:

class DCheckbox : DHtmlFormElement, IInput {
  this() {
    super("input");
    type("checkbox");
  }

  IHtmlAttribute type() {
    return attribute("type");
  }

  IHtmlElement type(string typeValue) {
    attribute("type", typeValue);
    return this;
  }
}