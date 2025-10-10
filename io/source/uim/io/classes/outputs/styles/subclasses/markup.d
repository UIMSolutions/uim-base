/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.styles.subclasses.markup;

mixin(Version!"test_uim_io");

import uim.io;

@safe:

class DMarkupOutputStyle : DOutputStyle {
  this() {
    super();
  }

  this(Json[string] initData) {
    super(initData);
  }

  this(string newName, Json[string] initData = null) {
    super(name, initData);
  }

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }

    return true;
  }

  // #region OutputType
  override OutputTypes outputType() {
    return _outputType;
  }

  override IOutputStyle outputType(OutputTypes type) {
    _outputType = type;
    return this;
  }
  // #endregion OutputType

  override string render(string text, string[string] values, OutputTypes outputType = OutputTypes.RENDER) {
    if (outputType == OutputTypes.RAW) {
      return text;
    }

    string styledTxt = text;
    if (outputType == OutputTypes.PLAIN) {
      values.keys
        .each!(key => styledTxt = styledTxt.removeCode(key));

      return styledTxt;
    }

    if (outputType == OutputTypes.RENDER) {
      values
        .each!((key, value) => styledTxt = styledTxt.replaceCode(key, value));

      return replaceCodes(values, styledTxt);
    }

    return text;
  }

  // #region replaceCode
  override string replaceCode(string text, string code) {
    return text.replace("<" ~ code ~ ">", "").replace("</" ~ code ~ ">", "");
  }
  // #endregion replaceCode

  // #region removeCode
  override string removeCode(string text, string code) {
    return text.replace("<" ~ code ~ ">", "").replace("</" ~ code ~ ">", "");
  }

  unittest {
    auto style = new DMarkupOutputStyle();

    // Test replaceCode: should remove both opening and closing tags
    string input = "<b>Hello</b> <i>World</i>";
    string expected = "Hello <i>World</i>";
    assert(style.replaceCode(input, "b") == expected, "replaceCode failed for <b>");

    input = "<i>Hello</i>";
    expected = "Hello";
    assert(style.replaceCode(input, "i") == expected, "replaceCode failed for <i>");

    // Test removeCode: should behave the same as replaceCode
    input = "<u>Test</u> <b>Bold</b>";
    expected = "Test <b>Bold</b>";
    assert(style.removeCode(input, "u") == expected, "removeCode failed for <u>");

    input = "<b>Bold</b>";
    expected = "Bold";
    assert(style.removeCode(input, "b") == expected, "removeCode failed for <b>");

    // Test with no tags present
    input = "Plain text";
    expected = "Plain text";
    assert(style.replaceCode(input, "b") == expected, "replaceCode failed for plain text");
    assert(style.removeCode(input, "b") == expected, "removeCode failed for plain text");

    // Test with nested tags
    input = "<b><i>Nested</i></b>";
    expected = "<i>Nested</i>";
    assert(style.replaceCode(input, "b") == expected, "replaceCode failed for nested <b>");
  }
  // #endregion removeCode
}
