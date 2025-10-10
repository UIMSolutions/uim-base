/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.formatters.formatter;

import uim.io;
import uim.io.classes.outputs.formatters.helpers.mixins;

mixin(Version!"test_uim_io");
@safe:

class DOutputFormatter : UIMObject, IOutputFormatter {
  mixin(OutputFormatterThis!"");

  override bool initialize(Json[string] initData = null) {
    if (!super.initialize(initData)) {
      return false;
    }
    return true;
  }

  // Outputs a single or multiple messages or newlines to stdout / stderr.
  IOutputFormatter write(string[] messages);
  IOutputFormatter write(string message);

  IOutputFormatter writeln(uint numberOfLines = 1);
  IOutputFormatter writeln(string[] messages, uint numberOfLines = 1);
  IOutputFormatter writeln(string message, uint numberOfLines = 1);

  // #region styles
  protected IOutputStyle[string] _styles;

  // Gets the current style definition by name.
  IOutputStyle style(string name) {
    return (name in _styles) ? _styles[name] : null;
  }

  // Sets a style definition by name.
  IOutputFormatter style(string name, IOutputStyle style) {
    _styles[name] = style;
    return this;
  }

  // Gets all the style definitions.
  IOutputStyle[string] styles() {
    return _styles;
  }

  // Sets all the style definitions.
  IOutputFormatter styles(IOutputStyle[string] newStyles) {
    _styles = newStyles;
    return this;
  }

  // Removes a style definition by name.
  IOutputFormatter removeStyle(string name) {
    _styles.remove(name);
    return this;
  }

  unittest {
    class DummyStyle : DOutputStyle {
    }

    DOutputFormatter formatter = new DOutputFormatter();

    // Test setting a style by name
    auto styleA = new DummyStyle();
    formatter.style("underline", styleA);
    assert(formatter.style("underline") is styleA, "Should set and get 'underline' style");

    // Test overwriting a style
    auto styleB = new DummyStyle();
    formatter.style("underline", styleB);
    assert(formatter.style("underline") is styleB, "Should overwrite 'underline' style");

    // Test setting multiple styles at once
    IOutputStyle[string] newStyles;
    auto styleC = new DummyStyle();
    auto styleD = new DummyStyle();
    newStyles["strike"] = styleC;
    newStyles["highlight"] = styleD;
    formatter.styles(newStyles);
    assert(formatter.style("strike") is styleC, "Should set 'strike' style via styles()");
    assert(formatter.style("highlight") is styleD, "Should set 'highlight' style via styles()");
    assert(formatter.styles().length == 2, "Should have 2 styles after bulk set");

    // Test removing a style
    formatter.removeStyle("strike");
    assert(formatter.style("strike") is null, "Should remove 'strike' style");
    assert(formatter.styles().length == 1, "Should have 1 style after removal");

    // Test removing a non-existent style (should not throw)
    formatter.removeStyle("nonexistent");
    assert(formatter.styles().length == 1, "Removing nonexistent style should not affect styles");

    // Test getting all styles
    auto allStyles = formatter.styles();
    assert("highlight" in allStyles, "Should contain 'highlight' style");
    assert(!("strike" in allStyles), "'strike' style should be removed");
  }
  // #endregion styles

  // #region outputType
  // Get the output type on how formatting tags are treated.
  protected OutputTypes _outputType;

  // Get the output type on how formatting tags are treated.
  OutputTypes outputType() {
    return _outputType;
  }

  IOutputFormatter outputType(OutputTypes type) {
    _outputType = type;
    return this;
  }

  unittest {
    class DummyStyle : DOutputStyle {
    }

    DOutputFormatter formatter = new DOutputFormatter();

    // Test default outputType (should be default initialized)
    assert(formatter.outputType() == formatter._outputType, "outputType() should return the internal _outputType");

    // Test setting outputType
    formatter.outputType(OutputTypes.RAW);
    assert(formatter.outputType() == OutputTypes.RAW, "outputType() should return OutputTypes.text after setting");

    formatter.outputType(OutputTypes.PLAIN);
    assert(formatter.outputType() == OutputTypes.PLAIN, "outputType() should return OutputTypes.ansi after setting");

    // Test fluent interface
    auto returned = formatter.outputType(OutputTypes.RENDER);
    assert(returned is formatter, "outputType(OutputTypes) should return this for chaining");
    assert(formatter.outputType() == OutputTypes.RENDER, "outputType() should return OutputTypes.RENDER after chaining");
  }
  // #endregion outputType

}
