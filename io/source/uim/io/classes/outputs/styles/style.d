module uim.io.classes.outputs.styles.style;

mixin(Version!"test_uim_io");

import uim.io;

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

  bool initialize(Json[string] initData = null) {
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
        .each!(key => styledTxt = styledTxt.removeStyleCode(key));

      if (!styledTxt.isNull) {
        return styledTxt;
      }
    }

    foreach (tag; styles.keys) {
      if (styledTxt.contains("<" ~ tag ~ ">")) {
        styledTxt = styledTxt.replace("<" ~ tag ~ ">", "").replace("</" ~ tag ~ ">", "");
        Json match = Json.emptyObject;
        match["tag"] = tag;
        match["text"] = styledTxt;
        return replaceTags(match);
      }
    }

    return text;
  }

  // #region removeStyleCode
  string removeStyleCodes(string[] styleCodes, string text) {
    styleCodes.each!(code => text = removeStyleCode(code, text));
    return text;
  }

  string removeStyleCode(string styleCode, string text) {
    return text.replace("<" ~ styleCode ~ ">", "").replace("</" ~ styleCode ~ ">", "");
  }
  // #endregion removeStyleCode
}
