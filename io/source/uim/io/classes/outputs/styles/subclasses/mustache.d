/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.io.classes.outputs.styles.mustache;


import uim.io;

mixin(Version!"test_uim_io");
@safe:

class DOutputStyle : UIMObject, IOutputStyle {
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
  OutputTypes outputType() {
    return _outputType;
  }

  IOutputStyle outputType(OutputTypes type) {
    _outputType = type;
    return this;
  }
  // #endregion OutputType

  string render(string text, string[string] values, OutputTypes outputType = OutputTypes.RENDER) {
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
  /* override */  string replaceCodes(string[string] styleCodes, string text) {
    styleCodes.keys
      .each!(code => text = replaceCode(code, text));
    return text;
  }  string replaceCode(string styleCode, string text) {
    return text.replace("{" ~ styleCode ~ "}", "");
  }
  // #endregion replaceCode

  // #region removeCode
  /* override */  string removeCode(string styleCode, string text) {
    return text.replace("{" ~ styleCode ~ "}", "");
  }
  // #endregion removeCode
}
