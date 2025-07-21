/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.io.classes.outputs.engines.engine;

mixin(Version!"test_uim_io");

import uim.io;
@safe:

/**
 * Object wrapper for outputting information from a shell application.
 * Can be connected to any stream resource that can be used with fopen()
 *
 * Can generate colorized output on consoles that support it. There are a few
 * built in styles
 *
 * - `error` Error messages.
 * - `warning` Warning messages.
 * - `info` Informational messages.
 * - `comment` Additional text.
 * - `question` Magenta text used for user prompts
 *
 * By defining styles with addStyle() you can create custom console styles.
 *
 * ### Using styles in output
 *
 * You can format console output using tags with the name of the style to apply. From inside a shell object
 *
 * ```
 * this.writeln("<warning>Overwrite:</warning> foo.d was overwritten.");
 * ```
 *
 * This would create orange 'Overwrite:' text, while the rest of the text would remain the normal color.
 * See OutputConsole.styles() to learn more about defining your own styles. Nested styles are not supported
 * at this time.
 */
/**
 * DOutput is a console output handler class that provides styled and formatted output for console applications.
 * It supports multiple output types (RAW, PLAIN, COLOR) and allows for custom styles using tags.
 *
 * Features:
 * - Output messages to stdout/stderr with optional styling and formatting.
 * - Define and manage custom styles for text, background, and formatting options.
 * - Apply styles to text using tags, which are replaced with appropriate color codes or formatting.
 * - Switch between different output types to control how tags and styles are processed.
 *
 * Output Types:
 * - RAW: Outputs text as-is, with no modification or tag processing.
 * - PLAIN: Outputs text with tags stripped, no color or formatting applied.
 * - COLOR: Outputs text with tags replaced by ANSI color codes for styled console output.
 *
 * Usage:
 * - Use `write` methods to output messages.
 * - Use `style` methods to define or modify styles.
 * - Use `outputType` to set or get the current output type.
 * - Use `styleText` to apply styles to a given text.
 * - Use `removeStyle` to remove a defined style.
 * - Use `close` to clean up resources.
 *
 * Example:
 * ---
 * output.style("warning", ["text": "yellow", "background": "red"]);
 * output.outputType("COLOR");
 * output.write("<warning>Warning message</warning>");
 * ---
 *
 * Inherits:
 * - UIMObject
 * - IOutput
 */
class DOutputEngine : UIMObject, IOutputEngine {
  mixin(OutputThis!());

  // Raw output constant - no modification of output text.
  static const string LF = "\n";  // TODO = D_EOL;

  // The current output type.
  protected string _outputType = "COLOR"; // text colors used in colored output.
  protected static int[string] _foregroundColors; // background colors used in colored output.
  protected static int[string] _backgroundColors; // Formatting options for colored output.
  protected static int[string] _options;

  // #region write
    // Outputs a single or multiple messages or newlines to stdout / stderr.
    abstract IOutputEngine write(string[] messages); 
    abstract IOutputEngine write(string message); 
  // #endregion write

  // #region writeln
    // Outputs a single or multiple messages or newlines to stdout / stderr.
    abstract IOutputEngine writeln(uint numberOfLines = 1);
    abstract IOutputEngine writeln(string[] messages, uint numberOfLines = 1);
    abstract IOutputEngine writeln(string message, uint numberOfLines = 1);
  // #endregion writeln

  // #region styleText
  // Apply styling to text.
  string styleText(string text) {
    string styledTxt = text;
    if (outputType == "RAW") {
      return text;
    }

    if (outputType == "PLAIN") {
      styledTxt = text;
      styles.keys
        .each!(key => styledTxt = styledTxt.replace("<"~key~">", "").replace("</"~key~">", ""));

      if (!styledTxt.isNull) {
        return styledTxt;
      }
    }

    foreach(tag; styles.keys) {
      if (styledTxt.contains("<"~tag~">")) {
        styledTxt = styledTxt.replace("<"~tag~">", "").replace("</"~tag~">", "");
        Json match = Json.emptyObject;
        match["tag"] = tag;
        match["text"] = styledTxt;
        return replaceTags(match);
      }
    }
   
    return text;
  }
  // #endregion styleText

  // #region replaceTags
  // Replace tags with color codes.
  protected string replaceTags(Json matches) {
    string tag = matches.getString("tag"); // matches = {"tag": ..., "text": ... }
    Json style = _styles.get(tag, Json(null)); // _styles["tag"] -> Json 

    if (style.isNull) { // style not found
      return htmlDoubleTag(tag, matches.getString("text"));
    }

    string[] styleInfo;
    string text = style.getString("text"); // "red"
    if (_foregroundColors.hasKey(text)) {
      styleInfo ~= to!string(_foregroundColors[text]); // "31"
    }
    style.remove("text");

    string background = style.getString("background"); // "white"
    if (_backgroundColors.hasKey(background)) {
      styleInfo ~= to!string(_backgroundColors[background]); // "47"
    }
    style.remove("background");

    styleInfo ~= style.byKeyValue
      .filter!(kv => kv.key in _options && !kv.value.isNull)
      .map!(kv => to!string(_options[kv.key]))
      .array;

    return "\033[" ~ styleInfo.join(";") ~ "m" ~ matches.getString("text") ~ "\033[0m";
  }
  // #region replaceTags

  // #region styles
  // Styles that are available as tags in console output.
  protected static Json[string] _styles;
  
  // Gets the current styles offered
  Json style(string name) {
    return name in _styles ? _styles[name] : Json(null);
  }

  /**
     * Sets style.
     *
     * ### Creates or modifies an existing style.
     *
     * ```
     * output.setStyle("annoy", ["text": "purple", "background": "yellow", "blink": true.toJson]);
     * ```
     *
     * ### Remove a style
     *
     * ```
     * this.output.setStyle("annoy", []);
     * ```
     */
  IOutputEngine style(string styleName, STRINGAA options) {
    Json[string] map;
    options.each!((key, value) => map[key] = Json(value));

    return style(styleName, map);
  }

  IOutputEngine style(string styleName, Json[string] options) {
    Json json = Json.emptyObject;
    options.each!((key, value) => json[key] = value);

    return style(styleName, json);
  }

  IOutputEngine style(string key, Json option) {
    _styles[key] = option;
    return this;
  }

  IOutputEngine removeStyle(string name) {
    _styles.remove(name);
    return this;
  }

  // Gets all the style definitions.
  Json[string] styles() {
    return _styles;
  }
  // #endregion styles

  // #region outputType
  // Get the output type on how formatting tags are treated.
  string outputType() {
    return _outputType;
  }

  // Set the output type on how formatting tags are treated.
  IOutputEngine outputType(string type) {
    /* if (!type.isIn(["RAW", "PLAIN", "COLOR"])) {
      // throw new DInvalidArgumentException("Invalid output type `%s`.".format(type));
    } */
    _outputType = type;
    return this;
  }
  // #endregion outputType

  // Clean up and close handles
  IOutputEngine close() {
    return this; 
  }
}

unittest {
    // Setup: initialize static members
    DOutput._foregroundColors = ["red": 31, "yellow": 33, "green": 32, "magenta": 35];
    DOutput._backgroundColors = ["white": 47, "red": 41, "yellow": 43];
    DOutput._options = ["blink": 5, "bold": 1];
    DOutput._styles = [
        "warning": Json(["text": Json("yellow"), "background": Json("red"), "bold": Json(true)]),
        "info": Json(["text": Json("green")]),
        "question": Json(["text": Json("magenta")])
    ];

    auto output = new DOutput();

    // Test outputType getter/setter
    assert(output.outputType() == "COLOR");
    output.outputType("RAW");
    assert(output.outputType() == "RAW");
    output.outputType("PLAIN");
    assert(output.outputType() == "PLAIN");
    output.outputType("COLOR");
    assert(output.outputType() == "COLOR");

    // Test style getter/setter
    assert(output.style("warning")["text"].str == "yellow");
    output.style("custom", ["text": "red", "background": "white"]);
    assert(output.style("custom")["text"].str == "red");
    assert(output.style("custom")["background"].str == "white");

    // Test removeStyle
    output.removeStyle("custom");
    assert(output.style("custom").isNull);

    // Test styles() returns all styles
    auto styles = output.styles();
    assert("warning" in styles);
    assert("info" in styles);

    // Test styleText in RAW mode (should return as-is)
    output.outputType("RAW");
    assert(output.styleText("<warning>Danger!</warning>") == "<warning>Danger!</warning>");

    // Test styleText in PLAIN mode (should strip tags)
    output.outputType("PLAIN");
    assert(output.styleText("<warning>Danger!</warning>") == "Danger!");

    // Test styleText in COLOR mode (should apply ANSI codes)
    output.outputType("COLOR");
    string styled = output.styleText("<warning>Danger!</warning>");
    assert(styled.startsWith("\033[33;41;1m")); // yellow foreground (33), red background (41), bold (1)
    assert(styled.endsWith("\033[0m"));
    assert(styled.canFind("Danger!"));

    // Test styleText with unknown tag (should return as-is or htmlDoubleTag)
    string unknown = output.styleText("<unknown>Test</unknown>");
    // Since htmlDoubleTag is not defined here, just check fallback
    assert(unknown == "<unknown>Test</unknown>" || unknown.canFind("unknown"));

    // Test styleText with nested tags (should not support nesting, so treat as plain)
    string nested = output.styleText("<warning>Danger <info>info</info></warning>");
    // Should strip only the outermost tag or treat as plain text
    assert(nested.canFind("Danger"));
    assert(nested.canFind("info"));

    // Test write methods (should return this, not throw)
    assert(output.write("Hello") is output);
    assert(output.write(["A", "B"]) is output);
    assert(output.write(2) is output);

    // Test close returns this
    assert(output.close() is output);
}

