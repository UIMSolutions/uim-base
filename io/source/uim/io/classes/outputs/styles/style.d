/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.styles.style;

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
  string replaceCodes(string text, string[string] styleCodes, ) {
    styleCodes.each!(code => text = text.replaceCode(code, value));
    return text;
  }

  string replaceCode(string text, string code) {
    return text.replace("<" ~ code ~ ">", "").replace("</" ~ code ~ ">", "");
  }
  // #endregion replaceCode

  // #region removeCode
  string removeCodes(string text, string[string] values) {
    return text.removeCode(values.keys);
  }

  string removeCodes(string text, string[] codes) {
    codes.each!(code => text = text.removeCode(code));
    return text;
  }

  string removeCode(string text, string code) {
    return text.replace("<" ~ code ~ ">", "").replace("</" ~ code ~ ">", "");
  }
  // #endregion removeCode
}
