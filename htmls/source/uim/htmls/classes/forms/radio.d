module uim.htmls.classes.forms.radio;

import uim.htmls;

@safe:

class DRadio : DHtmlFormElement  {
  this() {
    super("input");
    attribute("type", "radio");
  }

  IHtmlElement checked() {
    attribute("checked", "");
    return this;
  }

  IHtmlElement name(string nameValue) {
    attribute("name", nameValue);
    return this;
  }

  IHtmlAttribute name() {
    return attribute("name");
  }

  IHtmlElement value(string valueValue) {
    attribute("value", valueValue);
    return this;
  }

  IHtmlAttribute type() {
    return attribute("type");
  }
}